import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              // 設定画面に遷移する
              await Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logger.i('START MyHomePage increment');
          await ref.read(counterProvider.notifier).increment();
          logger.i('END MyHomePage increment');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  static const numbers = <int>[1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = ref.watch(numberProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: number,
              items: numbers
                  .map(
                    (m) => DropdownMenuItem<int>(
                      value: m,
                      child: Text(' + $m'),
                    ),
                  )
                  .toList(),
              onChanged: (m) {
                if (m != null) {
                  ref.read(numberProvider.notifier).state = m;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

final sharedPreferencesProvider = Provider.autoDispose<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final counterRepositoryProvider = Provider.autoDispose<CounterRepository>(
  (ref) {
    final repository = CounterRepository(ref.read);
    ref.onDispose(() {
      logger.v('[Dispose] CounterRepository ${repository.hashCode}');
    });
    logger.v('[Created] CounterRepository ${repository.hashCode}');
    return repository;
  },
);

class CounterRepository {
  CounterRepository(this._read);

  final Reader _read;

  Future<void> increment({
    required int number,
  }) async {
    logger.i('START CounterRepository increment');
    await _read(sharedPreferencesProvider).setInt('counterKey', get() + number);
    logger.i('END CounterRepository increment');
  }

  int get() {
    return _read(sharedPreferencesProvider).getInt('counterKey') ?? 0;
  }
}

final counterProvider =
    StateNotifierProvider.autoDispose<CounterStateNotifier, int>(
  (ref) {
    final notifier = CounterStateNotifier(ref.read);
    ref.onDispose(() {
      logger.v('[Dispose] CounterStateNotifier ${notifier.hashCode}');
    });
    logger.v('[Created] CounterStateNotifier ${notifier.hashCode}');
    return notifier;
  },
);

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier(this._read) : super(0) {
    _load();
  }

  final Reader _read;

  void _load() {
    state = _read(counterRepositoryProvider).get();
  }

  Future<void> increment() async {
    logger.i('START CounterStateNotifier increment');
    await _read(counterRepositoryProvider).increment(
      number: _read(numberProvider),
    );
    _load();
    logger.i('END CounterStateNotifier increment');
  }
}

/// ＜実装者の意図＞
/// 設定画面を抜けてもnumberProviderは維持させたい。
/// メモリ効率化の観点からautoDisposeはつけておきたい。
///
/// ＜実際の動き＞
/// 設定画面を抜けるとnumberProvierの値が初期値（1）に戻ってしまう（NG動作）
///
/// numberProviderはautoDisposeつけているので参照されなくなったら破棄される。
/// 値（状態）をメモリで保持しているので破棄されたら値が初期値（1）に戻る。
///
/// numberProviderを参照しているのは２箇所
/// ① 設定画面
/// ② CounterStateNotifierのincrement()
///
/// ② は都度参照（`_read(numberProvider)`）で参照値の保持はしていないため、
/// 設定画面を抜けると参照されなくなりnumberProviderが破棄され値が初期値（1）に戻ってしまう。
///
/// ＜問題点＞
/// Riverpodへの深い理解無しに（脳死で）Readerをコンストラクタに渡して都度参照（`_read(numberProvider)`）
/// していると、上記のような不具合が混入するリスクがある。このようなリスクは排除しておいたほうがよいと思う。
///
/// ＜改善方法＞
/// 改善方法は次の２つ。
/// A.このケースではautoDisposeをやめる
///  => 参照されなくなっても破棄されず値は維持される
///  => autoDisposeを正しく理解し運用する必要がある
/// B.次のようにCounterStateNotifierのコンストラクタに`ref.watch`で取得したnumberを与える
/// 　=> autoDisposeを付けていても参照が維持され破棄されなくなる
///
/// ```
/// return CounterStateNotifier(
///   number: ref.watch(numberProvider),
/// );
/// ```
///
/// 試しに、CounterStateNotifierのコンストラクタにAutoDisposeRef（ref）を与えて
/// CounterStateNotifier内部で`ref.watch(numberProvider)`したけど参照は維持されず
/// NG動作のままでした。
///
/// ＜とはいえ＞
/// ここまで書いて、上記問題点は考えすぎな気がしてきました。
/// ・Reader をコンストラクタに渡して都度Providerを参照する
/// ・autoDisposeをちゃんと理解して適切に運用する
/// でも問題ないと思いました！
final numberProvider = StateProvider.autoDispose<int>(
  (ref) {
    ref.onDispose(() {
      logger.v('[Dispose] number');
    });
    logger.v('[Created] number');
    return 1;
  },
);

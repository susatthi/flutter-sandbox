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
          IconButton(
            onPressed: () {
              logger.i('START refresh counterRepositoryProvider');
              ref.refresh(counterRepositoryProvider);
              logger.i('END refresh counterRepositoryProvider');
            },
            icon: const Icon(Icons.refresh),
          )
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

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final counterRepositoryProvider = Provider.autoDispose<CounterRepository>(
  (ref) {
    final repository = CounterRepository(ref.read);
    ref.onDispose(() {
      logger.i('[Dispose] CounterRepository ${repository.hashCode}');
    });
    logger.i('[Created] CounterRepository ${repository.hashCode}');
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
      logger.i('[Dispose] CounterStateNotifier ${notifier.hashCode}');
    });
    logger.i('[Created] CounterStateNotifier ${notifier.hashCode}');
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

final numberProvider = StateProvider.autoDispose<int>(
  (ref) {
    ref.onDispose(() {
      logger.i('[Dispose] number');
    });
    logger.i('[Created] number');
    return 1;
  },
);

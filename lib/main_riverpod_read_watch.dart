import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
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
            onPressed: () {
              // ref.invalidate(counterProvider);
              ref.invalidate(counterRepositoryProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(counterProvider.notifier).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterRepository {
  CounterRepository();

  int _counter = 0;

  Future<void> increment() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _counter++;
  }

  Future<int> get() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return _counter;
  }
}

final counterRepositoryProvider = Provider.autoDispose<CounterRepository>(
  (ref) {
    final repository = CounterRepository();
    ref.onDispose(() {
      logger.i('Disposed Repository: hashCode = ${repository.hashCode}');
    });
    logger.i('Created Repository: hashCode = ${repository.hashCode}');
    return repository;
  },
);

// パターン①：ref.watch()したRepositoryインスタンスをCounterStateNotifierに与える
// 結果：Repositoryがrefreshした時点でCounterStateNotifierが再生成されて_load()が発火してリビルドされて0になる。
final counterProvider =
    StateNotifierProvider.autoDispose<CounterStateNotifier, int>(
  (ref) {
    final counterRepository = ref.watch(counterRepositoryProvider);
    return CounterStateNotifier(counterRepository);
  },
);

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier(this.counterRepository) : super(0) {
    _load();
  }

  final CounterRepository counterRepository;

  Future<void> _load() async {
    state = await counterRepository.get();
  }

  Future<void> increment() async {
    await counterRepository.increment();
    await _load();
  }
}

// // パターン②：ref.read()したRepositoryインスタンスをCounterStateNotifierに与える
// // 結果：RepositoryがrefreshしてもCounterStateNotifierは古いRepositoryを使い続けてしまう
// final counterProvider =
//     StateNotifierProvider.autoDispose<CounterStateNotifier, int>(
//   (ref) {
//     final counterRepository = ref.read(counterRepositoryProvider);
//     return CounterStateNotifier(counterRepository);
//   },
// );

// class CounterStateNotifier extends StateNotifier<int> {
//   CounterStateNotifier(this.counterRepository) : super(0) {
//     _load();
//   }

//   final CounterRepository counterRepository;

//   Future<void> _load() async {
//     state = await counterRepository.get();
//   }

//   Future<void> increment() async {
//     await counterRepository.increment();
//     await _load();
//   }
// }

// // パターン③：ref.readをRepositoryインスタンスに与えて、コンストラクタでRepositoryをreadする
// // 結果：RepositoryがrefreshしてもCounterStateNotifierは古いRepositoryを使い続けてしまう
// final counterProvider =
//     StateNotifierProvider.autoDispose<CounterStateNotifier, int>(
//   (ref) => CounterStateNotifier(ref.read),
// );

// class CounterStateNotifier extends StateNotifier<int> {
//   CounterStateNotifier(Reader read)
//       : counterRepository = read(counterRepositoryProvider),
//         super(0) {
//     _load();
//   }

//   final CounterRepository counterRepository;

//   Future<void> _load() async {
//     state = await counterRepository.get();
//   }

//   Future<void> increment() async {
//     await counterRepository.increment();
//     await _load();
//   }
// }

// // パターン④：ref.readをRepositoryインスタンスに与えて、Repositoryを使うときに都度readする
// // 結果：_load()が終わるとRepositoryが破棄されてしまうので、ずっと0のまま
// final counterProvider =
//     StateNotifierProvider.autoDispose<CounterStateNotifier, int>(
//   (ref) => CounterStateNotifier(ref.read),
// );

// class CounterStateNotifier extends StateNotifier<int> {
//   CounterStateNotifier(this._read) : super(0) {
//     _load();
//   }

//   final Reader _read;

//   Future<void> _load() async {
//     state = await _read(counterRepositoryProvider).get();
//   }

//   Future<void> increment() async {
//     await _read(counterRepositoryProvider).increment();
//     await _load();
//   }
// }

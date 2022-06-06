import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              // ref.refresh(counterProvider);
              ref.refresh(counterRepositoryProvider);
            },
            icon: const Icon(Icons.refresh),
          )
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
              counter.when(
                data: (data) => '$data',
                error: (e, _) => '$e',
                loading: () => 'loading...',
              ),
              style: Theme.of(context).textTheme.headline4,
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

final counterRepositoryProvider = Provider<CounterRepository>(
  (ref) => CounterRepository(),
);

final counterProvider =
    StateNotifierProvider<CounterStateNotifier, AsyncValue<int>>(
  (ref) {
    final counterRepository = ref.watch(counterRepositoryProvider);
    return CounterStateNotifier(counterRepository);
  },
);

class CounterStateNotifier extends StateNotifier<AsyncValue<int>> {
  CounterStateNotifier(this.counterRepository)
      : super(const AsyncValue.loading()) {
    _load();
  }

  final CounterRepository counterRepository;

  Future<void> _load() async {
    state = await AsyncValue.guard(() async {
      return counterRepository.get();
    });
  }

  Future<void> increment() async {
    state = const AsyncValue.loading();
    await counterRepository.increment();
    await _load();
  }
}

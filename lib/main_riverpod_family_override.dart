import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_riverpod_family_override.g.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        scaffoldBackgroundColorProvider(brightness: Brightness.light)
            .overrideWith((ref) {
          final colorScheme =
              ref.watch(colorSchemeProvider(brightness: ref.brightness));
          return colorScheme.onInverseSurface;
        }),
        scaffoldBackgroundColorProvider(brightness: Brightness.dark)
            .overrideWith((ref) {
          final colorScheme =
              ref.watch(colorSchemeProvider(brightness: ref.brightness));
          return colorScheme.onInverseSurface;
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightThemeData =
        ref.watch(themeDataProvider(brightness: Brightness.light));
    final darkThemeData =
        ref.watch(themeDataProvider(brightness: Brightness.dark));
    final currentThemeMode = ref.watch(currentThemeModeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: currentThemeMode,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@riverpod
class CurrentThemeMode extends _$CurrentThemeMode {
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

@riverpod
ThemeData themeData(
  ThemeDataRef ref, {
  required Brightness brightness,
}) {
  final colorScheme = ref.watch(colorSchemeProvider(brightness: brightness));
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor:
        ref.watch(scaffoldBackgroundColorProvider(brightness: brightness)),
  );
}

@riverpod
ColorScheme colorScheme(
  ColorSchemeRef ref, {
  required Brightness brightness,
}) {
  return ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: Colors.blueAccent,
  );
}

@riverpod
Color? scaffoldBackgroundColor(
  ScaffoldBackgroundColorRef ref, {
  required Brightness brightness,
}) =>
    null;

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(currentThemeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentThemeMode.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(currentThemeModeProvider.notifier).toggle(),
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

part 'main_riverpod_launch_snackbar.freezed.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    // どの画面で発生したエラーでもここで一括でSnackBar表示ができる
    ref.listen<LaunchUrlState>(
      launchUrlStateProvider,
      (previous, next) {
        logger.i('status = ${next.status.name}, url = ${next.urlString}');
        if (next.status == LaunchUrlStatus.error) {
          // エラーの場合はSnackBar表示をする
          scaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: Text('${next.urlString} を開くことができませんでした'),
            ),
          );
        }
      },
    );

    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const Second(),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('https://keyber.jp'),
            onTap: () async {
              // 起動メソッドをプロバイダーから受け取、正常に開けるURLを渡して実行する
              // するとURLをブラウザで開くことができる
              await ref.read(launcherProvider)('https://keyber.jp');
            },
          ),
          ListTile(
            title: const Text('invalid://keyber.jp'),
            onTap: () async {
              // 開けないURLを開くと起動URL状態がエラーになりSnackBarが表示される
              // SnackBarを開く処理は個々の画面ではなくMyAppに集約されている
              await ref.read(launcherProvider)('invalid://keyber.jp');
            },
          ),
        ],
      ),
    );
  }
}

class Second extends ConsumerWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('invalid://keyber.jp'),
            onTap: () async {
              // 開けないURLを開くと起動URL状態がエラーになりSnackBarが表示される
              // SnackBarを開く処理は個々の画面ではなくMyAppに集約されている
              await ref.read(launcherProvider)('invalid://keyber.jp');
            },
          ),
        ],
      ),
    );
  }
}

/// URL起動状態
///
/// URL起動に成功したかどうかのステータスを持つ
@freezed
class LaunchUrlState with _$LaunchUrlState {
  const factory LaunchUrlState({
    String? urlString,
    @Default(LaunchMode.platformDefault) LaunchMode mode,
    @Default(LaunchUrlStatus.wating) LaunchUrlStatus status,
  }) = _LaunchUrlState;
}

/// URL起動のステータス
enum LaunchUrlStatus {
  /// 起動前
  wating,

  /// 起動できた
  success,

  /// 起動できなかった
  error;
}

/// URL起動状態のプロバイダー
final launchUrlStateProvider = StateProvider<LaunchUrlState>(
  (ref) => const LaunchUrlState(),
);

/// URL起動モードプロバイダー
final launchModeProvider = Provider(
  (ref) => LaunchMode.inAppWebView,
);

/// URL起動メソッドプロバイダー
///
/// UI側でこのメソッドを使ってURL起動をする
final launcherProvider = Provider(
  (ref) {
    final stateNotifier = ref.read(launchUrlStateProvider.notifier);
    final mode = ref.read(launchModeProvider);
    return (String urlString) async {
      // 起動前で更新する
      stateNotifier.state = LaunchUrlState(
        urlString: urlString,
        mode: mode,
      );

      try {
        final url = Uri.parse(urlString);
        final result = await launchUrl(url, mode: mode);

        // 起動成功 or エラーで更新する
        stateNotifier.update(
          (state) => state.copyWith(
            status: result ? LaunchUrlStatus.success : LaunchUrlStatus.error,
          ),
        );
        // ignore: avoid_catching_errors
      } on ArgumentError catch (_) {
        // エラーで更新する
        stateNotifier.update(
          (state) => state.copyWith(
            status: LaunchUrlStatus.error,
          ),
        );
      }
    };
  },
);

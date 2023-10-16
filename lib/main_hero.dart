import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'back-button',
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            const Text('Hero Sample'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'container',
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push<void>(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => const NextPage(),
                      transitionDuration: const Duration(milliseconds: 1000),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 1000),
                    ),
                  );
                },
                child: const Text('次のページへ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
        leading: Hero(
          tag: 'back-button',
          child: Material(
            type: MaterialType.transparency,
            child: BackButton(
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
          // flightShuttleBuilder: (
          //   flightContext,
          //   animation,
          //   flightDirection,
          //   fromHeroContext,
          //   toHeroContext,
          // ) {
          //   return const Placeholder();
          // },
          // placeholderBuilder: (context, size, child) {
          //   return const Placeholder();
          // },
        ),
      ),
      body: Hero(
        tag: 'container',
        child: Container(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

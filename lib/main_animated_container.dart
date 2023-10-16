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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _key = GlobalKey<_AnimatedAppBarBackgroundState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer Sample'),
        flexibleSpace: SafeArea(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _AnimatedAppBarBackground(
              key: _key,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _key.currentState?.fill();
        },
        tooltip: 'refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

/// 背景が広がるアニメーション
class _AnimatedAppBarBackground extends StatefulWidget {
  const _AnimatedAppBarBackground({super.key});

  @override
  State<_AnimatedAppBarBackground> createState() =>
      _AnimatedAppBarBackgroundState();
}

class _AnimatedAppBarBackgroundState extends State<_AnimatedAppBarBackground> {
  static const Duration _animateDuration = Duration(milliseconds: 300);
  static const _initMargin = EdgeInsets.only(left: 18);
  static const double _initWidth = 200;
  static const double _initHeight = 48;
  static const double _initRadius = 25;

  bool _isFilled = false;
  Duration _duration = _animateDuration;
  EdgeInsets _margin = _initMargin;
  double _width = _initWidth;
  double _height = _initHeight;
  double _radius = _initRadius;

  /// 広がる
  void fill({
    bool animated = true,
  }) {
    if (_isFilled) {
      return;
    }

    final size = MediaQuery.of(context).size;
    setState(() {
      _isFilled = true;
      _duration = animated ? _animateDuration : Duration.zero;
      _margin = EdgeInsets.zero;
      _width = size.width;
      _height = size.height;
      _radius = 0;
    });
  }

  /// 畳む
  void _collapse({
    bool animated = true,
  }) {
    if (!_isFilled) {
      return;
    }
    setState(() {
      _isFilled = false;
      _duration = animated ? _animateDuration : Duration.zero;
      _margin = _initMargin;
      _width = _initWidth;
      _height = _initHeight;
      _radius = _initRadius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.decelerate,
      duration: _duration,
      width: _width,
      height: _height,
      margin: _margin,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
      onEnd: () {
        _collapse(animated: false);
      },
      child: const SizedBox(),
    );
  }
}

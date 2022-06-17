import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var _useMaterial3 = true;

  void _toggleMaterial() {
    setState(() {
      _useMaterial3 = !_useMaterial3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: _useMaterial3,
        colorSchemeSeed: _useMaterial3 ? Colors.green : null,
        primarySwatch: _useMaterial3 ? null : Colors.green,
      ),
      home: MyHomePage(
        useMaterial3: _useMaterial3,
        onTap: _toggleMaterial,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
    required bool useMaterial3,
    required this.onTap,
  })  : materialVersion = useMaterial3 ? '3' : '2',
        super(key: key);

  final String materialVersion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Material Design $materialVersion Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('ElevatedButton'),
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('FilledButton'),
            ),
            const SizedBox(height: 30),
            FilledTonalButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('FilledTonalButton'),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('OutlinedButton'),
            ),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('TextButton'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTap,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FilledButton extends _FilledButton {
  const FilledButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    required super.child,
  }) : super(type: _ButtonType.filled);

  factory FilledButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) = _FilledButtonWithIcon;

  static ButtonStyle styleFrom({
    Color? primary,
    Color? onPrimary,
    Color? onSurface,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return ElevatedButton.styleFrom(
      primary: primary,
      onPrimary: onPrimary,
      onSurface: onSurface,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }
}

class _FilledButtonWithIcon extends FilledButton
    with _IconButtonDefaultStyleMixin {
  _FilledButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _FilledButtonWithIconChild(
            icon: icon,
            label: label,
          ),
        );

  @override
  _ButtonType get type => _ButtonType.filled;
}

class FilledTonalButton extends _FilledButton {
  const FilledTonalButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    required super.child,
  }) : super(type: _ButtonType.filledTonal);

  factory FilledTonalButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) = _FilledTonalButtonWithIcon;

  static ButtonStyle styleFrom({
    Color? primary,
    Color? onPrimary,
    Color? onSurface,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) {
    return ElevatedButton.styleFrom(
      primary: primary,
      onPrimary: onPrimary,
      onSurface: onSurface,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }
}

class _FilledTonalButtonWithIcon extends FilledTonalButton
    with _IconButtonDefaultStyleMixin {
  _FilledTonalButtonWithIcon({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _FilledButtonWithIconChild(
            icon: icon,
            label: label,
          ),
        );

  @override
  _ButtonType get type => _ButtonType.filledTonal;
}

abstract class _FilledButton extends ElevatedButton {
  const _FilledButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    required super.child,
    required this.type,
  });

  final _ButtonType type;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = ElevatedButton.styleFrom(
      onPrimary: _onPrimary(colorScheme),
      primary: _primary(colorScheme),
    );
    return super.defaultStyleOf(context).copyWith(
          foregroundColor: style.foregroundColor,
          backgroundColor: style.backgroundColor,
          overlayColor: style.overlayColor,
          elevation: MaterialStateProperty.all(0),
        );
  }

  // https://github.com/darrenaustin/flutter/blob/d8435ca1e908b937c45ed54ba08bf97dc3312a1d/examples/api/lib/material/button_style/button_style.0.dart#L64-L86
  Color _primary(ColorScheme colorScheme) {
    switch (type) {
      case _ButtonType.filled:
        return colorScheme.primary;
      case _ButtonType.filledTonal:
        return colorScheme.secondaryContainer;
    }
  }

  Color _onPrimary(ColorScheme colorScheme) {
    switch (type) {
      case _ButtonType.filled:
        return colorScheme.onPrimary;
      case _ButtonType.filledTonal:
        return colorScheme.onSecondaryContainer;
    }
  }
}

class _FilledButtonWithIconChild extends StatelessWidget {
  const _FilledButtonWithIconChild({
    required this.label,
    required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    // ignore: omit_local_variable_types
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon,
        SizedBox(width: gap),
        Flexible(child: label),
      ],
    );
  }
}

mixin _IconButtonDefaultStyleMixin on _FilledButton {
  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding),
        );
  }
}

enum _ButtonType {
  filled,
  filledTonal,
}

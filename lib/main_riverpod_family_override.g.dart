// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'main_riverpod_family_override.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeDataHash() => r'066ba3bfaecb14c3171ed9e65fef032aea151196';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [themeData].
@ProviderFor(themeData)
const themeDataProvider = ThemeDataFamily();

/// See also [themeData].
class ThemeDataFamily extends Family<ThemeData> {
  /// See also [themeData].
  const ThemeDataFamily();

  /// See also [themeData].
  ThemeDataProvider call({
    required Brightness brightness,
  }) {
    return ThemeDataProvider(
      brightness: brightness,
    );
  }

  @override
  ThemeDataProvider getProviderOverride(
    covariant ThemeDataProvider provider,
  ) {
    return call(
      brightness: provider.brightness,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'themeDataProvider';
}

/// See also [themeData].
class ThemeDataProvider extends AutoDisposeProvider<ThemeData> {
  /// See also [themeData].
  ThemeDataProvider({
    required Brightness brightness,
  }) : this._internal(
          (ref) => themeData(
            ref as ThemeDataRef,
            brightness: brightness,
          ),
          from: themeDataProvider,
          name: r'themeDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$themeDataHash,
          dependencies: ThemeDataFamily._dependencies,
          allTransitiveDependencies: ThemeDataFamily._allTransitiveDependencies,
          brightness: brightness,
        );

  ThemeDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brightness,
  }) : super.internal();

  final Brightness brightness;

  @override
  Override overrideWith(
    ThemeData Function(ThemeDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ThemeDataProvider._internal(
        (ref) => create(ref as ThemeDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brightness: brightness,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ThemeData> createElement() {
    return _ThemeDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ThemeDataProvider && other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThemeDataRef on AutoDisposeProviderRef<ThemeData> {
  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ThemeDataProviderElement extends AutoDisposeProviderElement<ThemeData>
    with ThemeDataRef {
  _ThemeDataProviderElement(super.provider);

  @override
  Brightness get brightness => (origin as ThemeDataProvider).brightness;
}

String _$colorSchemeHash() => r'25d6131bae8e9aefe6e48769ceb79ca015ab4279';

/// See also [colorScheme].
@ProviderFor(colorScheme)
const colorSchemeProvider = ColorSchemeFamily();

/// See also [colorScheme].
class ColorSchemeFamily extends Family<ColorScheme> {
  /// See also [colorScheme].
  const ColorSchemeFamily();

  /// See also [colorScheme].
  ColorSchemeProvider call({
    required Brightness brightness,
  }) {
    return ColorSchemeProvider(
      brightness: brightness,
    );
  }

  @override
  ColorSchemeProvider getProviderOverride(
    covariant ColorSchemeProvider provider,
  ) {
    return call(
      brightness: provider.brightness,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'colorSchemeProvider';
}

/// See also [colorScheme].
class ColorSchemeProvider extends AutoDisposeProvider<ColorScheme> {
  /// See also [colorScheme].
  ColorSchemeProvider({
    required Brightness brightness,
  }) : this._internal(
          (ref) => colorScheme(
            ref as ColorSchemeRef,
            brightness: brightness,
          ),
          from: colorSchemeProvider,
          name: r'colorSchemeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$colorSchemeHash,
          dependencies: ColorSchemeFamily._dependencies,
          allTransitiveDependencies:
              ColorSchemeFamily._allTransitiveDependencies,
          brightness: brightness,
        );

  ColorSchemeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brightness,
  }) : super.internal();

  final Brightness brightness;

  @override
  Override overrideWith(
    ColorScheme Function(ColorSchemeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ColorSchemeProvider._internal(
        (ref) => create(ref as ColorSchemeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brightness: brightness,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ColorScheme> createElement() {
    return _ColorSchemeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ColorSchemeProvider && other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ColorSchemeRef on AutoDisposeProviderRef<ColorScheme> {
  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ColorSchemeProviderElement
    extends AutoDisposeProviderElement<ColorScheme> with ColorSchemeRef {
  _ColorSchemeProviderElement(super.provider);

  @override
  Brightness get brightness => (origin as ColorSchemeProvider).brightness;
}

String _$scaffoldBackgroundColorHash() =>
    r'6ef21c85c0857adc04bfa6edeaf061f02db5ea5e';

/// See also [scaffoldBackgroundColor].
@ProviderFor(scaffoldBackgroundColor)
const scaffoldBackgroundColorProvider = ScaffoldBackgroundColorFamily();

/// See also [scaffoldBackgroundColor].
class ScaffoldBackgroundColorFamily extends Family<Color?> {
  /// See also [scaffoldBackgroundColor].
  const ScaffoldBackgroundColorFamily();

  /// See also [scaffoldBackgroundColor].
  ScaffoldBackgroundColorProvider call({
    required Brightness brightness,
  }) {
    return ScaffoldBackgroundColorProvider(
      brightness: brightness,
    );
  }

  @override
  ScaffoldBackgroundColorProvider getProviderOverride(
    covariant ScaffoldBackgroundColorProvider provider,
  ) {
    return call(
      brightness: provider.brightness,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scaffoldBackgroundColorProvider';
}

/// See also [scaffoldBackgroundColor].
class ScaffoldBackgroundColorProvider extends AutoDisposeProvider<Color?> {
  /// See also [scaffoldBackgroundColor].
  ScaffoldBackgroundColorProvider({
    required Brightness brightness,
  }) : this._internal(
          (ref) => scaffoldBackgroundColor(
            ref as ScaffoldBackgroundColorRef,
            brightness: brightness,
          ),
          from: scaffoldBackgroundColorProvider,
          name: r'scaffoldBackgroundColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scaffoldBackgroundColorHash,
          dependencies: ScaffoldBackgroundColorFamily._dependencies,
          allTransitiveDependencies:
              ScaffoldBackgroundColorFamily._allTransitiveDependencies,
          brightness: brightness,
        );

  ScaffoldBackgroundColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brightness,
  }) : super.internal();

  final Brightness brightness;

  @override
  Override overrideWith(
    Color? Function(ScaffoldBackgroundColorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ScaffoldBackgroundColorProvider._internal(
        (ref) => create(ref as ScaffoldBackgroundColorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brightness: brightness,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Color?> createElement() {
    return _ScaffoldBackgroundColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScaffoldBackgroundColorProvider &&
        other.brightness == brightness;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brightness.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ScaffoldBackgroundColorRef on AutoDisposeProviderRef<Color?> {
  /// The parameter `brightness` of this provider.
  Brightness get brightness;
}

class _ScaffoldBackgroundColorProviderElement
    extends AutoDisposeProviderElement<Color?> with ScaffoldBackgroundColorRef {
  _ScaffoldBackgroundColorProviderElement(super.provider);

  @override
  Brightness get brightness =>
      (origin as ScaffoldBackgroundColorProvider).brightness;
}

String _$currentThemeModeHash() => r'd9481ce042e25730eab040ae1fad5fdce0ca160d';

/// See also [CurrentThemeMode].
@ProviderFor(CurrentThemeMode)
final currentThemeModeProvider =
    AutoDisposeNotifierProvider<CurrentThemeMode, ThemeMode>.internal(
  CurrentThemeMode.new,
  name: r'currentThemeModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentThemeMode = AutoDisposeNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

enum NavigationIndicators { sticky, end }

class AppTheme extends ChangeNotifier {
  AccentColor _color = systemAccentColor;
  AccentColor get color => _color;
  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  static Color get accentTextColor {
    return const Color(0xFFDDDDDD);
  }

  static Color get secondaryTextColor {
    return const Color(0xFFC6C6C6);
  }

  static Color get textColor {
    return const Color(0xFF989CA7);
  }

  static Color get disabledTextColor {
    return const Color(0xFF9AA1AB);
  }

  static Color get scaffoldColor {
    return const Color(0xff0f1118);
  }

  static Color get scaffold2Color {
    return const Color(0xff111827);
  }

  static Color get buttonBgColor {
    return const Color(0xff1C222E);
  }

  static Color get buttonBgHoveredColor {
    return const Color(0xff374151);
  }

  static Color get buttonBorderColor {
    return const Color(0xff343E4D);
  }

  static Color get buttonTextColor {
    return const Color(0xffD1D5DB);
  }

  static Color get blue {
    return const Color(0xff2563EB);
  }

  static Color get cardColor {
    return const Color(0xff191A23);
  }

  static Color get cardBorderColor {
    return const Color(0xff313239);
  }

  static Color get tableHeaderColor {
    return const Color(0xFF9299A4);
  }

  static Color get tableBorderColor {
    return const Color(0xFF374151);
  }

  static Color get tableBgColor {
    return const Color(0xff191B27);
  }

  ThemeMode _mode = ThemeMode.dark;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.auto;
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    notifyListeners();
  }

  WindowEffect _windowEffect = WindowEffect.disabled;
  WindowEffect get windowEffect => _windowEffect;
  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    notifyListeners();
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }

  TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection direction) {
    _textDirection = direction;
    notifyListeners();
  }

  Locale? _locale;
  Locale? get locale => _locale;
  set locale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
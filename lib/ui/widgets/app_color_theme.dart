import 'package:flutter/material.dart';

class AppColorTheme extends InheritedWidget {
  final AppTheme theme;

  const AppColorTheme({
    Key? key,
    required Widget child,
    required this.theme,
  }) : super(key: key, child: child);

  static AppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppColorTheme>()?.theme;
  }

  @override
  bool updateShouldNotify(AppColorTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}

class AppTheme {
  final Color primaryColor;
  final Color headerColor;
  final Color textColor;

  AppTheme({
    required this.primaryColor,
    required this.headerColor,
    required this.textColor,
  });
}

final appThemes = <AppTheme>[
  AppTheme(
    primaryColor: const Color(0xFF60AEA7),
    headerColor: const Color(0xFFF3685A),
    textColor: const Color(0xFFA95F81),
  ),
  AppTheme(
    primaryColor: const Color(0xFF919F67),
    headerColor: const Color(0xFF7CA0A8),
    textColor: const Color(0xFF6F5762),
  ),
  AppTheme(
    primaryColor: const Color(0xFFEBB935),
    headerColor: const Color(0xFF273430),
    textColor: const Color(0xFFB19184),
  ),
  AppTheme(
    primaryColor: const Color(0xFFD28E6E),
    headerColor: const Color(0xFF99AEC8),
    textColor: const Color(0xFFB9697A),
  ),
  AppTheme(
    primaryColor: const Color(0xFFAC8A6C),
    headerColor: const Color(0xFFDEA95E),
    textColor: const Color(0xFF877F7A),
  ),
  AppTheme(
    primaryColor: const Color(0xFF858890),
    headerColor: const Color(0xFFEA405C),
    textColor: const Color(0xFFC7A285),
  )
];

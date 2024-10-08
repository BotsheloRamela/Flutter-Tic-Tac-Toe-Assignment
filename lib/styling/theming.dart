import 'package:flutter/material.dart';

const Color _background = Color(0xFF232C46);
const Color _primary = Color(0xFF5E8BFD);
const Color _primaryInverse = Color(0xFFFFFFFF);
const Color _secondary = Color(0xFFFDED5E);
const Color _onBackground = Color(0xFF3F4E6B);
const Color _surfaceContainerHighest = Color(0xFF93A5D4);
const Color _surfaceContainerLowest = Color(0xFF000000);

final mainTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: _background,
    onSurface: _onBackground,
    secondary: _secondary,
    primary: _primary,
    inversePrimary: _primaryInverse,
    surfaceContainerHighest: _surfaceContainerHighest,
    surfaceContainerLowest: _surfaceContainerLowest,
  ),
  useMaterial3: false,
  iconTheme: const IconThemeData(size: 24),
  fontFamily: 'Inter',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(
      color: _surfaceContainerHighest,
      fontSize: 80,
      fontWeight: FontWeight.w900,
    ),
    titleMedium: TextStyle(
      color: _surfaceContainerHighest,
      fontSize: 32,
      fontWeight: FontWeight.w900,
    ),
    titleSmall: TextStyle(
      color: _surfaceContainerHighest,
      fontSize: 30,
      fontWeight: FontWeight.w900,
    ),
    labelMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
  ),
);

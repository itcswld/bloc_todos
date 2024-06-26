import 'package:flutter/material.dart';

class TodosTheme {
  static ThemeData get light => ThemeData(
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 117, 208, 247)),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF13B9FF)),
        snackBarTheme:
            const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      );
  static ThemeData get dark => ThemeData(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 16, 46, 59)),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF13B9FF),
          brightness: Brightness.dark,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      );
}

// File: lib/app/theme.dart

import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey[50],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  primaryTextTheme: TextTheme(
    titleMedium: TextStyle(color: Colors.black, fontSize: 18),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/theme.dart';
import 'pages/home_page.dart';
import 'providers/app_state_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Iframe Dashboard',
      theme: appTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

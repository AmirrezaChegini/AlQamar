import 'package:al_qamar/config/theme.dart';
import 'package:al_qamar/pages/main_wrapper/main_wrapper_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainWrapperPage(),
    );
  }
}

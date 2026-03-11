import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/focus/screens/focus_home_screen.dart';

void main() {
  runApp(const FocusZenApp());
}

class FocusZenApp extends StatelessWidget {
  const FocusZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusZen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const FocusHomeScreen(),
    );
  }
}

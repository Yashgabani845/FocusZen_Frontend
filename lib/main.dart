import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focusappfrontend/theme/app_theme.dart';
import 'package:focusappfrontend/theme/services/theme_provider.dart';
import 'package:focusappfrontend/intro/screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const FocusZenApp(),
    ),
  );
}

class FocusZenApp extends StatelessWidget {
  const FocusZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer rebuilds the app when theme colors change
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'FocusZen',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}

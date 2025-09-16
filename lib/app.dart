// lib/app.dart

import 'package:flutter/material.dart';
import 'package:cliploops/core/theme/app_theme.dart';
import 'package:cliploops/features/welcome/welcome_main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home | ClipLoops',
      theme: AppTheme.lightTheme,       
      darkTheme: AppTheme.darkTheme,      
      themeMode: ThemeMode.system,     
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      home: const WelcomeMain(title: 'Flutter Demo Home Page'),
    );
  }
}

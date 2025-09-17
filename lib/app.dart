// lib/app.dart

import 'package:flutter/material.dart';
import 'package:cliploops/core/theme/app_theme.dart';
// import 'package:cliploops/features/welcome/welcome_main.dart';
import '/core/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Home | ClipLoops',
      theme: AppTheme.darkTheme,       
      // darkTheme: AppTheme.darkTheme,      
      // themeMode: ThemeMode.system,     
      debugShowCheckedModeBanner: false,
      // home: const WelcomeMain(),
    );
  }
}

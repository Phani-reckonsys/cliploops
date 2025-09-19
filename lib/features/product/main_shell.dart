// lib/main_shell.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cliploops/features/product/custom_bottom_navbar.dart'; // Your navbar path

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -200,
          left: -200,
          width: 800,
          child: Image.asset('assets/top-background-2.png', fit: BoxFit.cover),
        ),
        Scaffold(
          // The body will be the page content from the router
          backgroundColor: Colors.transparent,
          body: navigationShell,
          // The bottom navigation bar is now part of the shell
          bottomNavigationBar: CustomBottomNavbar(
            navigationShell: navigationShell,
          ),
        ),
      ],
    );
  }
}

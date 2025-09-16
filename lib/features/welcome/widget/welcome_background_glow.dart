// lib/screens/welcome/widgets/welcome_background_glow.dart

import 'dart:ui';
import 'package:flutter/material.dart';

class WelcomeBackgroundGlow extends StatelessWidget {
  const WelcomeBackgroundGlow({super.key});

  @override
  Widget build(BuildContext context) {
    // This Stack contains all the decorative, blurred shapes.
    // It's a self-contained background effect.
    return Stack(
      children: [
        Positioned(
          left: 20.37,
          top: -0.19,
          child: Container(
            transform: Matrix4.rotationZ(0.99),
            width: 320.29,
            height: 122.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(130),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(147, 0, 27, 1).withAlpha(100),
                  blurRadius: 50.0,
                  spreadRadius: 20.0,
                  offset: const Offset(10, 8),
                ),
              ],
            ),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130),
                child: Container(
                  transform: Matrix4.rotationZ(1.3),
                  width: 320.29,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: const Color.fromRGBO(147, 0, 27, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(130),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 10.76,
          top: -20,
          child: Container(
            transform: Matrix4.rotationZ(0.99),
            width: 400.29,
            height: 21,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(130),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    255,
                    255,
                    255,
                  ).withAlpha(100),
                  blurRadius: 50.0,
                  spreadRadius: 10.0,
                  offset: const Offset(18, 6),
                ),
              ],
            ),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130),
                child: Container(
                  transform: Matrix4.rotationZ(1.3),
                  width: 400.29,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(130),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 58.76,
          top: -120,
          child: Container(
            transform: Matrix4.rotationZ(0.99),
            width: 500.29,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(130),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(25, 0, 86, 1).withAlpha(128),
                  blurRadius: 50.0,
                  spreadRadius: 20.0,
                  offset: const Offset(10, 8),
                ),
              ],
            ),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130),
                child: Container(
                  transform: Matrix4.rotationZ(1.3),
                  width: 500.29,
                  height: 110,
                  decoration: ShapeDecoration(
                    color: const Color.fromRGBO(25, 0, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(130),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// lib/features/welcome/welcome_main.dart
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:cliploops/shared/widget/filled_red_button.dart";
import 'package:cliploops/features/welcome/widget/animated_welcome_images.dart';
import 'package:cliploops/features/welcome/widget/welcome_background_glow.dart';
import 'package:cliploops/features/welcome/widget/welcome_text_carousel.dart';

class WelcomeMain extends StatefulWidget {
  const WelcomeMain({super.key});

  @override
  State<WelcomeMain> createState() => _WelcomeMainState();
}

class _WelcomeMainState extends State<WelcomeMain> {
  final List<Map<String, String>> _welcomeContent = const [
    {
      'title': 'Cut, Loop & Customize Your Music',
      'description':
          'Cut, loop, and tweak your music with ease! Get creative and make your sound totally your own!',
    },
    {
      'title': 'Edit, Repeat, and Personalize Your Tracks',
      'description':
          'Cut, loop, and tweak your music with ease! Get creative and make your sound totally your own!',
    },
    {
      'title': 'Get readymade clips for ringtones & more',
      'description':
          'Cut, loop, and tweak your music with ease! Get creative and make your sound totally your own!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            const WelcomeBackgroundGlow(),
            SizedBox(
              width: screenSize.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AnimatedWelcomeImages(),
                  const SizedBox(height: 38),
                  WelcomeTextCarousel(content: _welcomeContent),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: FilledRedButton(
                    text: "Get Started",
                    onPressed: () {
                      print(
                        "Button tapped at ${DateTime.now().toIso8601String()} in Bengaluru!",
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

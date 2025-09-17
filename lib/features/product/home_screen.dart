import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // The main widget is now a Stack to layer the background and the content
    return Stack(
      children: [
        // LAYER 1: The Background Image
        // It fills the entire screen from the very top.
        Positioned(
          top: -200,
          left: -200,
          width: 800,
          child: Container(
            child: Image.asset(
              'assets/top-background-2.png',
              fit: BoxFit.cover, // Ensures the image covers the whole screen
            ),
          ),
        ),

        // LAYER 2: The Scaffold (UI Content)
        // We make the Scaffold itself transparent to see the Stack's background.
        Scaffold(
          backgroundColor:
              Colors.transparent, // CRUCIAL: Make Scaffold see-through
          appBar: AppBar(
            // CRUCIAL: Make AppBar see-through as well
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove the shadow
            // Your title content remains the same
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage("assets/dummy-avatar.png"),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Hello Phani",
                    // Optional: Add a shadow to the text for better readability
                    style: TextStyle(
                      shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: const Center(
            child: Text(
              "Home Page",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

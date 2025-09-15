import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home | ClipLoops',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            Positioned(
              left: 20.37,
              top: -0.19,
              child: Container(
                transform: Matrix4.rotationZ(0.99),
                width: 320.29,
                height: 122.11,
                // This outer container casts the shadow
                decoration: BoxDecoration(
                  // Note: Using BoxDecoration here for shadows as it's common
                  // when the child already has a defined shape.
                  borderRadius: BorderRadius.circular(130),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(147, 0, 27, 1).withAlpha(100),
                      blurRadius: 50.0,
                      spreadRadius: 20.0,
                      offset: Offset(10, 8),
                    ),
                  ],
                ),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
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
            ),
            Positioned(
              left: 10.76,
              top: -20,
              child: Container(
                transform: Matrix4.rotationZ(0.99),
                width: 400.29,
                height: 21,
                // This outer container casts the shadow
                decoration: BoxDecoration(
                  // Note: Using BoxDecoration here for shadows as it's common
                  // when the child already has a defined shape.
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
                      offset: Offset(18, 6),
                    ),
                  ],
                ),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
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
            ),
            Positioned(
              left: 58.76,
              top: -120,
              child: Container(
                transform: Matrix4.rotationZ(0.99),
                width: 500.29,
                height: 110,
                // This outer container casts the shadow
                decoration: BoxDecoration(
                  // Note: Using BoxDecoration here for shadows as it's common
                  // when the child already has a defined shape.
                  borderRadius: BorderRadius.circular(130),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(25, 0, 86, 1).withAlpha(128),
                      blurRadius: 50.0,
                      spreadRadius: 20.0,
                      offset: Offset(10, 8),
                    ),
                  ],
                ),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
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
            ),

            SizedBox(
              width: screenSize.width,
              height: screenSize.height* 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/cliploopOnboarding-1.png',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const SizedBox(height: 38),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      'Cut,Loop & Customize Your Music',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'GT Walsheim Trial',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: 0.32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      'Cut, loop, and tweak your music with ease! Get creative and make your sound totally your own!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFB6B6B6),
                        fontSize: 16,
                        fontFamily: 'GT Walsheim Trial',
                        fontWeight: FontWeight.w400,
                        height: 1.10,
                        letterSpacing: 0.16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 38),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Container(
                        width: 15,
                        height: 5,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFF2F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF505050),
                          shape: OvalBorder(),
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF505050),
                          shape: OvalBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                // This creates the 50px space from the absolute bottom of the screen
                padding: const EdgeInsets.only(bottom: 50.0),
                // This widget makes the button take up 90% of the screen width
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your button's onPressed logic
                    },
                    style: ElevatedButton.styleFrom(
                      // Using the newer 'backgroundColor' and 'foregroundColor' properties
                      backgroundColor: const Color(0xFFFF2F2F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // With a fixed width, we only need vertical padding for height
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'GT Walsheim Trial',
                      ),
                      elevation: 10,
                      shadowColor: Colors.black.withAlpha(100),
                    ),
                    child: const Text("Get Started"),
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

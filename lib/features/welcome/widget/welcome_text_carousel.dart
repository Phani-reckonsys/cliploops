import 'dart:async';
import 'package:flutter/material.dart';

class WelcomeTextCarousel extends StatefulWidget {
  final List<Map<String, String>> content;

  const WelcomeTextCarousel({
    super.key,
    required this.content,
  });

  @override
  State<WelcomeTextCarousel> createState() => _WelcomeTextCarouselState();
}

class _WelcomeTextCarouselState extends State<WelcomeTextCarousel> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Ensure there's content to animate before starting the timer.
    if (widget.content.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.content.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If there's no content, return an empty container to avoid errors.
    if (widget.content.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Animated Title
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: FractionallySizedBox(
            key: ValueKey<int>(_currentIndex),
            widthFactor: 0.8,
            child: Text(
              widget.content[_currentIndex]['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'GT Walsheim Trial',
                fontWeight: FontWeight.w700,
                height: 1.10,
                letterSpacing: 0.32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 38),

        // Animated Description
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: FractionallySizedBox(
            key: ValueKey<int>(_currentIndex),
            widthFactor: 0.8,
            child: Text(
              widget.content[_currentIndex]['description']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFB6B6B6),
                fontSize: 16,
                fontFamily: 'GT Walsheim Trial',
                fontWeight: FontWeight.w400,
                height: 1.10,
                letterSpacing: 0.16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 38),

        // Animated Page Indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.content.length, (index) {
            bool isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: isActive ? 15 : 5,
              height: 5,
              decoration: ShapeDecoration(
                color: isActive
                    ? const Color(0xFFFF2F2F)
                    : const Color(0xFF505050),
                shape: isActive
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      )
                    : const OvalBorder(),
              ),
            );
          }),
        ),
      ],
    );
  }
}
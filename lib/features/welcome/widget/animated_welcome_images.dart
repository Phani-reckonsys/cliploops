import 'dart:async';
import 'package:flutter/material.dart';

// A helper class to hold the widget and its position for sorting.

class _StackItem {
  final Widget widget;
  final int stackPosition;
  _StackItem({required this.widget, required this.stackPosition});
}

class AnimatedWelcomeImages extends StatefulWidget {
  const AnimatedWelcomeImages({super.key});

  @override
  State<AnimatedWelcomeImages> createState() => _AnimatedWelcomeImagesState();
}

class _AnimatedWelcomeImagesState extends State<AnimatedWelcomeImages> {
  final List<String> _imageAssets = [
    'assets/cliploopwelcome-1.png',
    'assets/cliploopwelcome-2.png',
    'assets/cliploopwelcome-3.png',
  ];

  late final Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _imageAssets.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: MediaQuery.of(context).size.width * 0.8,

      child: Stack(
        alignment: Alignment.center,
        children: _buildAnimatedImages(),
      ),
    );
  }

  List<Widget> _buildAnimatedImages() {
    final List<_StackItem> items = [];
    final imageWidth = MediaQuery.of(context).size.width * 0.8;
    const animationDuration = Duration(milliseconds: 700);

    for (int i = 0; i < _imageAssets.length; i++) {
      final int stackPosition =
          (i - _currentIndex + _imageAssets.length) % _imageAssets.length;

      double bottomOffset = 0;
      double scale = 1.0;

      switch (stackPosition) {
        case 0:
          bottomOffset = 0;
          scale = 0.8;
          break;

        case 1:
          bottomOffset = 20;
          scale = 0.9;
          break;

        case 2:
          bottomOffset = 40;
          scale = 1.0;
          break;
      }

      final widget = AnimatedPositioned(
        key: ValueKey(_imageAssets[i]),
        duration: animationDuration,
        curve: Curves.easeInOut,
        bottom: bottomOffset,
        child: AnimatedScale(
          duration: animationDuration,
          curve: Curves.easeInOut,
          scale: scale,
          child: Image.asset(_imageAssets[i], width: imageWidth),
        ),
      );

      items.add(_StackItem(widget: widget, stackPosition: stackPosition));
    }

    items.sort((a, b) => a.stackPosition.compareTo(b.stackPosition));
    return items.map((item) => item.widget).toList();
  }
}

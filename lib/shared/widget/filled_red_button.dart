// lib/widgets/filled_red_button.dart

import 'package:flutter/material.dart';

class FilledRedButton extends StatelessWidget {
  /// The text displayed on the button.
  final String text;

  /// The callback that is executed when the button is tapped.
  final VoidCallback onPressed;

  const FilledRedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF2F2F),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'GT Walsheim Trial',
        ),
        elevation: 10,
        shadowColor: Colors.black.withAlpha(100),
      ),
      child: Text(text),
    );
  }
}

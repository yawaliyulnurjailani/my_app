import 'package:flutter/material.dart';

class TextButtonComp {
  static TextButton textButton1({
    required Widget text,
    required VoidCallback onPressed,
    required Color textHoverColor,
    required Color hoverColor,
    required EdgeInsetsGeometry padding,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.hovered)) {
              return hoverColor;
            }
            return Colors.transparent;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.hovered)) {
              return textHoverColor;
            }
            return Colors.black;
          },
        ),
        textStyle: WidgetStateProperty.resolveWith<TextStyle?>(
          (states) {
            if (states.contains(WidgetState.hovered)) {
              return const TextStyle(
                fontWeight: FontWeight.bold,
              );
            }
            return const TextStyle(
              fontWeight: FontWeight.normal,
            );
          },
        ),
        padding: WidgetStateProperty.all(
          padding,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: text,
    );
  }
}

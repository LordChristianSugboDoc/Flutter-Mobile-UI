import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final double inputHeight;
  final double inputWidth;
  final double fontSize;
  final Color fontColor;
  final Color buttonColor;
  final Color buttonOutline;
  final double outlineWidth;

  CustomPrimaryButton({
    required this.text,
    required this.onPress,
    required this.inputHeight,
    required this.inputWidth,
    required this.fontSize,
    required this.fontColor,
    required this.buttonColor,
    required this.buttonOutline,
    required this.outlineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputWidth,
      height: inputHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: buttonOutline,
          width: outlineWidth,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.maxFinite, 50),
          primary: buttonColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ), // Apply border radius here
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

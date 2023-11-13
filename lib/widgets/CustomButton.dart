import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final double height;
  final double width;
  final double fontSize;
  final Color fontColor;
  final Color buttonColor;
  final Color buttonOutline;

  CustomButton({
    required this.text,
    required this.onPress,
    required this.height,
    required this.width,
    required this.fontSize,
    required this.fontColor,
    required this.buttonColor,
    required this.buttonOutline,
  });

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: buttonOutline,
          width: 2,
        ),
      ),
      child: SizedBox(
        height: height, // Set the desired height of the button
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

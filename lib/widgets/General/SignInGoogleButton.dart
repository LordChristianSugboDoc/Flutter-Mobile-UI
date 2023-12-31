import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onPress;
  final Color buttonColor;
  final double borderWidth;

  const GoogleButton(
      {super.key, required this.onPress,
      required this.buttonColor,
      required this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 50), backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ), // Apply border radius here
        ),
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: borderWidth,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Image.asset(
              'assets/images/PNG/google_logo.png',
              height: 25, // Set the desired height
              width: 25,
              // Set the desired width
            ),
          ),
        ],
      ),
    );
  }
}

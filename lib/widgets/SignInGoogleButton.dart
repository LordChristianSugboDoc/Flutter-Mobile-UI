import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color buttonColor;

  GoogleButton(
      {required this.text, required this.onPress, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 50),
        primary: buttonColor,
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
          const SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Image.asset(
              'assets/images/google_logo.png',
              height: 25, // Set the desired height
              width: 25,
              // Set the desired width
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xFF424E79),
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

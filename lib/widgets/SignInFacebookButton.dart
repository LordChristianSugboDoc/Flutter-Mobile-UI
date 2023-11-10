import 'package:flutter/material.dart';

class FacebookButton extends StatelessWidget {
  final VoidCallback onPress;
  final Color buttonColor;
  final double borderWidth;

  FacebookButton(
      {required this.onPress,
      required this.buttonColor,
      required this.borderWidth});

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
          SizedBox(
            width: borderWidth,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Image.asset(
              'assets/images/facebook_logo.png',
              height: 25,
              width: 25,
            ),
          ),
        ],
      ),
    );
  }
}

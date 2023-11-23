import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {
  final VoidCallback onPress;
  final Color buttonColor;
  final double borderWidth;
  final double borderHeight;
  final double fontSize;
  final String labelText;
  final String asset;

  CustomSignInButton({
    required this.onPress,
    required this.buttonColor,
    required this.borderWidth,
    required this.borderHeight,
    required this.fontSize,
    required this.labelText,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: borderWidth,
      height: borderHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF4454C3).withOpacity(0.5), // Adjust the border color
          width: .8, // Adjust the border width
        ),
        borderRadius: BorderRadius.circular(5.0), // Apply border radius here
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(1, 50), // Adjust the minimumSize directly
          primary: buttonColor,
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Image.asset(
                asset,
                height: 25,
                width: 25,
              ),
            ),
            Text(
              labelText,
              style: TextStyle(
                color: Color(0xFF424E79),
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

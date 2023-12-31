import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color buttonColor;

  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPress,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 50),
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
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
          Text(
            text,
            style: const TextStyle(fontSize: 17, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

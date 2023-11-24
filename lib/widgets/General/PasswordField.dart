import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onTap;
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const PasswordField(
      {super.key, required this.obscureText,
      required this.onTap,
      required this.labelText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12,
              right: 15,
              bottom: 10,
            ),
            child: Icon(obscureText ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF424E79)),
          ),
        ),
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Color(0xFF424E79),
        ), // Change label text color
        hintStyle: const TextStyle(
          color: Color.fromARGB(130, 66, 78, 121),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide:
              BorderSide(color: Color(0xFF424E79)), // Change border color
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
              color: Color.fromARGB(
                  41, 66, 78, 121)), // Change border color when enabled
        ),
      ),
      controller: controller,
    );
  }
}

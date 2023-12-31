import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;

  const CustomTextField(
      {super.key, required this.labelText,
      required this.hintText,
      required this.controller,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      decoration: InputDecoration(
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

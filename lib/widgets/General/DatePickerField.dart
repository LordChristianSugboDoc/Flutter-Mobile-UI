import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double inputWidth;
  final double inputHeight;
  final TextEditingController controller;
  final VoidCallback function;

  const DatePickerField({super.key, 
    required this.labelText,
    required this.hintText,
    required this.inputWidth,
    required this.inputHeight,
    required this.controller,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: inputHeight,
      width: inputWidth,
      child: TextFormField(
        readOnly: true,
        controller: controller,
        onTap: function,
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
            borderSide: BorderSide(
              color: Color(0xFF424E79), // Change border color
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(
                  41, 66, 78, 121), // Change border color when enabled
            ),
          ),
        ),
      ),
    );
  }
}

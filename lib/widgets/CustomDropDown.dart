import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String selectedValue;
  final double inputWidth;
  final double inputHeight;
  final List<String> items;
  final void Function(String?)? onChanged;

  CustomDropDown({
    required this.labelText,
    required this.hintText,
    required this.selectedValue,
    required this.inputWidth,
    required this.inputHeight,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: inputWidth,
      height: inputHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(41, 66, 78, 121),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: PopupMenuButton<String>(
          onSelected: onChanged,
          itemBuilder: (BuildContext context) {
            return items.map((String value) {
              return PopupMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList();
          },
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            title: Text(
              selectedValue,
              style: const TextStyle(
                color: Color(0xFF424E79),
              ),
            ),
            trailing:
                const Icon(Icons.arrow_drop_down, color: Color(0xFF424E79)),
          ),
        ),
      ),
    );
  }
}

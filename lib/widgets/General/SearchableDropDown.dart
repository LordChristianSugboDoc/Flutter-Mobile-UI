import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class SearchableDropDown extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String selectedValue;
  final double inputWidth;
  final double inputHeight;
  final List<String> items;
  final void Function(String?)? onChanged;

  const SearchableDropDown({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.selectedValue,
    required this.inputWidth,
    required this.inputHeight,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

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
      child: Focus(
        onFocusChange: (hasFocus) {
          // Handle focus change to move labelText to border
          onChanged?.call(null); // Clear the text when focus changes
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SimpleAutoCompleteTextField(
                    key: GlobalKey<AutoCompleteTextFieldState<String>>(),
                    decoration: InputDecoration(
                      hintText: hintText,
                      labelText: labelText,
                      border: InputBorder.none,
                    ),
                    controller: TextEditingController(text: selectedValue),
                    suggestions: items,
                    textChanged: (value) {},
                    clearOnSubmit: false,
                    textSubmitted: (value) {
                      onChanged?.call(value);
                    },
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF424E79),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

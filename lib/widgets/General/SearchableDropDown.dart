import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0), // Adjust the padding as needed
        child: TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              border: InputBorder.none,
            ),
            controller: TextEditingController(text: selectedValue),
          ),
          suggestionsCallback: (pattern) async {
            return items
                .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            onChanged?.call(suggestion);
          },
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';

class CustomImageDisplay extends StatelessWidget {
  final double inputHeight;
  final double inputWidth;
  final File? image;
  final VoidCallback onTap;
  final TextEditingController imagePathController;

  const CustomImageDisplay({super.key, 
    required this.inputHeight,
    required this.inputWidth,
    required this.image,
    required this.onTap,
    required this.imagePathController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: inputWidth,
        height: inputHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(41, 66, 78, 121),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: image == null
            ? const Center(
                child: Icon(
                  Icons.add_a_photo,
                  color: Color(0xFF424E79),
                ),
              )
            : Image.file(
                image!,
                width: inputWidth,
                height: inputHeight,
                // fit: BoxFit.cover,
              ),
      ),
    );
  }
}

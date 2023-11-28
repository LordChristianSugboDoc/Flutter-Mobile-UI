import 'dart:io';
import 'package:flutter/material.dart';

class CustomImageDisplay extends StatelessWidget {
  final double inputHeight;
  final double inputWidth;
  final File? image;
  final VoidCallback onTap;
  final TextEditingController imagePathController;

  const CustomImageDisplay({
    super.key,
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
          borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        ),
        child: image == null
            ? const Center(
                child: Icon(
                  Icons.add_a_photo,
                  color: Color(0xFF424E79),
                ),
              )
            : Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100.0)),
                      child: Image.file(
                        image!,
                        width: inputWidth,
                        height: inputHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: inputWidth * .35,
                        height: inputHeight * .35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF4454C3),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: inputWidth * .15,
                          ),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

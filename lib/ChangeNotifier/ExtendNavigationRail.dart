import 'package:flutter/material.dart';

class ExtendNavigationRail extends ChangeNotifier {
  int _index = 0; // Use a private variable for index

  int get index => _index;
  bool isExtended = true;
  bool isImageVisible = true;
  bool isTextVisible = true;
  bool changeIcon = true;

  void isCondition() {
    isExtended = !isExtended;
    isImageVisible = !isImageVisible;
    isTextVisible = !isTextVisible;
    changeIcon = !changeIcon;

    notifyListeners();
  }

  void setPage(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}

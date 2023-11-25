import 'package:flutter/material.dart';

class ExtendNavigationRail extends ChangeNotifier {
  int _index = 0; // Use a private variable for index
  double width = .771;
  int get index => _index;
  bool isLeading = true;
  bool isTrailing = true;
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

  void changeWidth() {
    this.width = (this.width == 0.771) ? 0.910 : 0.771;
    notifyListeners();
  }
}

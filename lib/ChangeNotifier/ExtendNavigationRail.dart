import 'package:flutter/material.dart';

class ExtendNavigationRail extends ChangeNotifier {
  int _index = 0;
  double width = .771;
  int get index => _index;
  bool isLeading = true;
  bool isTrailing = true;
  bool isExtended = true;
  bool isImageVisible = true;
  bool isTextVisible = true;
  bool changeIcon = true;

  int _prescriptionPage = 0;
  int get prescriptionPage => _prescriptionPage;

  int _pastVisitPage = 0;
  int get pastVisitPage => _pastVisitPage;

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

  void updatePrescriptionPage(int newIndex) {
    this._prescriptionPage = newIndex;
    notifyListeners();
  }

  void updatePastVisitsPage(int newIndex) {
    this._pastVisitPage = newIndex;
    notifyListeners();
  }
}

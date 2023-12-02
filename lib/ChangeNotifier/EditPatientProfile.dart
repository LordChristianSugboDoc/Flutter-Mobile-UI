import 'package:flutter/material.dart';

class EditPatientProfile extends ChangeNotifier {
  String selectedCountry = '';
  String selectedProvince = '';
  String selectedCity = '';
  String selectedBrgy = '';
  bool _hasFocus = false;
  bool get hasFocus => _hasFocus;

  void setFocus(bool focus) {
    _hasFocus = focus;
    notifyListeners();
  }

  void updateSelectedCountry(String value) {
    selectedCountry = value ?? '';
    notifyListeners();
  }

  void updateSelectedProvince(String value) {
    selectedProvince = value ?? '';
    notifyListeners();
  }

  void updateSelectedCity(String value) {
    selectedCity = value ?? '';
    notifyListeners();
  }

  void updateSelectedBrgy(String value) {
    selectedBrgy = value ?? '';
    notifyListeners();
  }
}

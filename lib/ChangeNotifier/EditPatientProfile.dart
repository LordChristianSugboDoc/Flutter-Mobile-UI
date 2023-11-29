import 'package:flutter/material.dart';

class EditPatientProfile extends ChangeNotifier {
  String selectedCountry = 'Country';
  String selectedProvince = 'Province';
  String selectedCity = 'City';
  String selectedBrgy = 'Barangay';

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

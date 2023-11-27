import 'package:flutter/material.dart';

class EditPatientProfile extends ChangeNotifier {
  String selectedCountry = 'Country';
  String selectedState = 'Province';
  String selectedCity = 'City';
  String selectedBrgy = 'Barangay';

  void updateSelectedCountry(String value) {
    selectedCountry = value ?? '';
    notifyListeners();
  }

  void updateSelectedState(String value) {
    selectedState = value ?? '';
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

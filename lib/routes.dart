import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/dashboard.dart';
import 'package:flutter_doctor_ui/screens/login.dart';
import 'package:flutter_doctor_ui/screens/patient_profile.dart';
import 'package:flutter_doctor_ui/screens/patient_profile_edit.dart';
import 'package:flutter_doctor_ui/screens/registration.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
  Dashboard.routeName: (BuildContext context) => const Dashboard(
        patientId: "",
      ),
  PatientProfile.routeName: (BuildContext context) =>
      const PatientProfile(patientId: ""),
  PatientProfileEdit.routeName: (BuildContext context) => PatientProfileEdit(),
};

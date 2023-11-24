import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Dashboard/dashboard.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile_edit.dart';
import 'package:flutter_doctor_ui/screens/Registration/registration.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (BuildContext context) => const Login(),
  Registration.routeName: (BuildContext context) => const Registration(),
  Dashboard.routeName: (BuildContext context) => const Dashboard(
        patientId: "",
      ),
  PatientProfile.routeName: (BuildContext context) =>
      const PatientProfile(patientId: ""),
  PatientProfileEdit.routeName: (BuildContext context) => const PatientProfileEdit(),
};

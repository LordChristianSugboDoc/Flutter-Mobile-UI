import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Dashboard/dashboard.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile_edit.dart';

AppBar PatientProfileAppBar(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    iconTheme: const IconThemeData(
      color: Color(0xFF4454C3),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pushNamed(context, Dashboard.routeName);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 26,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10.0),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, PatientProfileEdit.routeName);
          },
          icon: const Icon(
            Icons.border_color_outlined,
            size: 26,
          ),
        ),
      )
    ],
  );
}

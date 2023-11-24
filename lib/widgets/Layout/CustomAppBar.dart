import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile.dart';

AppBar CustomAppBar(BuildContext context, Map<String, dynamic> patientData,
    Future<void> Function() fetchDashboard) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    iconTheme: const IconThemeData(
      color: Color(0xFF4454C3),
    ),
    title: Image.asset(
      'assets/images/PNG/sugbodoc_logo.png',
      height: 84.38, // Aspect Ratio 16:9
      width: 150,
    ),
    centerTitle: true,
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, PatientProfile.routeName);
        },
        child: Container(
          margin: const EdgeInsets.only(right: 17),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: (patientData['image'] != null)
                ? Image.network(
                    'http://10.0.2.2:8080/flutter-mobile-backend-ui/${patientData['image']}',
                    height: 90, // Aspect Ratio 5:3
                    width: 54,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/JPG/default_profile.jpg',
                    height: 90, // Aspect Ratio 5:3
                    width: 54,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    ],
  );
}

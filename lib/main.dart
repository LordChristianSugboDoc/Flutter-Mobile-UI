import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/routes.dart';
import 'package:flutter_doctor_ui/screens/login.dart';

int globalId = -1;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Login.routeName,
    routes: routes,
  ));
}

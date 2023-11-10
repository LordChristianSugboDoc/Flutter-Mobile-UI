import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/login.dart';
import 'package:flutter_doctor_ui/screens/registration.dart';

final Map<String, WidgetBuilder> routes = {
  Login.routeName: (BuildContext context) => Login(),
  Registration.routeName: (BuildContext context) => Registration(),
};

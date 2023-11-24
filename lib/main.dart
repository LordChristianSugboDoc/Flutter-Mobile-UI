import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/routes.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';

int globalId = -1;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExtendNavigationRail(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Login.routeName,
        routes: routes,
      ),
    ),
  );
}

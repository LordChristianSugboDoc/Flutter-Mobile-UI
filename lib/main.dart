import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/routes.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';

int globalId = -1;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ExtendNavigationRail>(
          create: (context) => ExtendNavigationRail(),
        ),
        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        initialRoute: Login.routeName,
        routes: routes,
      ),
    ),
  );
}

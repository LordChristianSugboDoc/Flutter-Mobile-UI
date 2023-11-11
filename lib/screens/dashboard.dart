import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/login.dart';
import 'package:flutter_doctor_ui/widgets/NavBar.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: NavBar(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        iconTheme: const IconThemeData(
          color: Color(0xFF4454C3),
        ),
        title: Image.asset(
          'assets/images/sugbodoc_logo.png',
          height: 80, // Set the desired height
          width: 160, // Set the desired width
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Login.routeName, (Route<dynamic> route) => false);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20.0, left: 15.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Column(
                  children: [
                    Text(
                      "Hello, Luke",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "How are you feeling today?",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/stethoscope.jpg',
                  height: 100,
                  width: 150,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

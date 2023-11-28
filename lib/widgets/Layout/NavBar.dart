import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';

class NavBar extends StatelessWidget {
  final VoidCallback _logout;

  NavBar(this._logout);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      backgroundColor: const Color(0xFF4454C3),
      child: ListView(
        padding: const EdgeInsets.only(top: 40.0),
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 17), // Set the desired left margin
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/PNG/sugbodoc_white_logo.png',
                height: 80, // Set the desired height
                width: 160, // Set the desired width
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.dashboard_outlined,
              color: Colors.white,
            ),
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const ListTile(
            leading: Icon(
              Icons.co_present_rounded,
              color: Colors.white,
            ),
            title: Text(
              'My Procedures',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const ListTile(
            leading: Icon(
              Icons.event_available_outlined,
              color: Colors.white,
            ),
            title: Text(
              'Appointments',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const ListTile(
            leading: Icon(
              Icons.analytics_outlined,
              color: Colors.white,
            ),
            title: Text(
              'My Lab Results',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const ListTile(
            leading: Icon(
              Icons.insert_chart_outlined_rounded,
              color: Colors.white,
            ),
            title: Text(
              'My Clinical Notes',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const ListTile(
            leading: Icon(
              Icons.medication,
              color: Colors.white,
            ),
            title: Text(
              'Prescription',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const ListTile(
            leading: Icon(
              Icons.create_new_folder_outlined,
              color: Colors.white,
            ),
            title: Text(
              'Files',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            //onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(top: 240.0),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Login.routeName, (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white, // Set your desired color
              ),
            ),
            onTap: () {
              _logout;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Login.routeName, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

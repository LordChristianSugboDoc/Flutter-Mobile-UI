import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/widgets/Layout/CustomNavigationRail.dart';

class LargeScreenDashboardBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> patientCareTeam;
  final List<Map<String, dynamic>> patientPrescriptions;
  final List<Map<String, dynamic>> patientEncounters;
  final ValueChanged<int> onDestinationSelected;

  LargeScreenDashboardBody(
    this.patientData,
    this.patientCareTeam,
    this.patientPrescriptions,
    this.patientEncounters,
    this.onDestinationSelected,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomNavigationRail(
            onDestinationSelected: onDestinationSelected,
          ),
          // Add your content based on the selected index
        ],
      ),
    );
  }
}

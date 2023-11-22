import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/Body/SmallScreenDashboardBody.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_doctor_ui/widgets/Layout/CustomAppBar.dart';
import 'package:flutter_doctor_ui/widgets/Layout/CustomBottomNav.dart';
import 'package:flutter_doctor_ui/widgets/Layout/NavBar.dart';

class Dashboard extends StatefulWidget {
  final String patientId;
  static String routeName = "/dashboard";

  const Dashboard({Key? key, required this.patientId}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<void> _fetchDashboardFuture;

  Map<String, dynamic> patientData = {};
  Map<String, dynamic> patientCareTeam = {};
  List<Map<String, dynamic>> patientPrescriptions = [];
  List<Map<String, dynamic>> patientEncounters = [];

  @override
  void initState() {
    super.initState();
    _fetchDashboardFuture = _fetchDashboard();
  }

  Future<void> _fetchDashboard() async {
    String patientDetailsURL =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientDetails/${globalId}';
    String careTeamURL =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientCareTeam/${globalId}';
    String prescriptionsURL =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientPrescriptions/${globalId}';
    String encountersURL =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientEncounters/${globalId}';

    try {
      final responsePatientDetails =
          await http.get(Uri.parse(patientDetailsURL));
      final responseCareTeam = await http.get(Uri.parse(careTeamURL));
      final responsePrescriptions = await http.get(Uri.parse(prescriptionsURL));
      final responseEncounters = await http.get(Uri.parse(encountersURL));

      // Handle the response
      print(
          'Response Status Patient Data Code: ${responsePatientDetails.statusCode}');
      print('Response Patient Data Body: ${responsePatientDetails.body}');

      print(
          'Response Status Patient Care Team Code: ${responseCareTeam.statusCode}');
      print('Response Patient Care Team Body: ${responseCareTeam.body}');

      print(
          'Response Status Patient Prescriptions Code: ${responsePrescriptions.statusCode}');
      print(
          'Response Patient Prescriptions Body: ${responsePrescriptions.body}');

      print(
          'Response Status Patient Encounters Code: ${responseEncounters.statusCode}');
      print('Response Patient Encounters Body: ${responseEncounters.body}');

      if (responsePatientDetails.statusCode == 200) {
        setState(() {
          patientData = json.decode(responsePatientDetails.body);
          patientCareTeam = json.decode(responseCareTeam.body);

          print('Patient Care Team: ${patientCareTeam}');
          // Ensure the correct type for patientPrescriptions
          if (responsePrescriptions.statusCode == 200) {
            final decodedData = json.decode(responsePrescriptions.body);

            if (decodedData is List) {
              // Explicitly cast each item to Map<String, dynamic>
              patientPrescriptions = List<Map<String, dynamic>>.from(
                decodedData.map<Map<String, dynamic>>(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );

              print(patientPrescriptions);
            } else {
              throw Exception('Invalid data format for prescriptions');
            }
          } else {
            throw Exception('Failed to load patient prescriptions');
          }

          if (responseEncounters.statusCode == 200) {
            final decodedData = json.decode(responseEncounters.body);

            if (decodedData is List) {
              // Explicitly cast each item to Map<String, dynamic>
              patientEncounters = List<Map<String, dynamic>>.from(
                decodedData.map<Map<String, dynamic>>(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for Encounters');
            }
          } else {
            throw Exception('Failed to load patient encounters');
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: _fetchDashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4454C3)),
              ),
            );
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Display your UI based on the fetched data
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              drawer: const NavBar(),
              appBar: CustomAppBar(context, patientData, _fetchDashboard),
              bottomNavigationBar: CustomBottomNav(),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  // Check the screen width and adjust the layout accordingly
                  if (constraints.maxWidth < 412) {
                    // Small screen layout
                    return SmallScreenDashboardBody(
                      patientData,
                      patientCareTeam,
                      patientPrescriptions,
                      patientEncounters,
                    );
                  } else {
                    // Large screen layout
                    return _buildLargeScreenLayout();
                  }
                },
              ),
            ); // Replace with your actual UI
          }
        },
      ),
    );
  }

  Widget _buildLargeScreenLayout() {
    // Build UI for large screens
    return Center(
      child: Text('Large Screen Layout'),
    );
  }
}

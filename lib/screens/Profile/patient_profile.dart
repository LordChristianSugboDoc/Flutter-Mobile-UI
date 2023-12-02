import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/widgets/Profile/LargePatientProfileBody.dart';
import 'package:flutter_doctor_ui/widgets/Profile/PatientProfileAppBar.dart';
import 'package:flutter_doctor_ui/widgets/Profile/SmallPatientProfileBody.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientProfile extends StatefulWidget {
  final String patientId;
  static String routeName = "/patientprofile";

  const PatientProfile({Key? key, required this.patientId}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  late Future<void> _fetchPatientProfileFuture;
  Map<String, dynamic> responseData = {};
  Map<String, dynamic> patientData = {};
  Map<String, dynamic> patientCountry = {};
  Map<String, dynamic> patientState = {};
  Map<String, dynamic> patientCity = {};
  Map<String, dynamic> patientBrgy = {};
  Map<String, dynamic> patientCareTeam = {};
  List<Map<String, dynamic>> communityPosts = [];

  double smallWidth = 600;
  double mediumWidth = 1000;

  @override
  void initState() {
    super.initState();
    _fetchPatientProfileFuture = _fetchPatientProfile();
  }

  Future<void> _fetchPatientProfile() async {
    String patientDetailsURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_details/$globalId';
    String careTeamURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_care_team/$globalId';
    String communityPostsURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/patient/get_community_posts';

    try {
      final responsePatientDetails =
          await http.get(Uri.parse(patientDetailsURL));
      final responseCareTeam = await http.get(Uri.parse(careTeamURL));
      final responseCommunityPosts =
          await http.get(Uri.parse(communityPostsURL));

      // Handle the response
      print(
          'Response Status Patient Data Code: ${responsePatientDetails.statusCode}');
      print('Response Patient Data Body: ${responsePatientDetails.body}');

      print(
          'Response Status Patient Care Team Code: ${responseCareTeam.statusCode}');
      print('Response Patient Care Team Body: ${responseCareTeam.body}');

      print(
          'Response Status Community Posts Code: ${responseCommunityPosts.statusCode}');
      print('Response Community Posts Body: ${responseCommunityPosts.body}');

      if (responsePatientDetails.statusCode == 200) {
        setState(() {
          responseData = json.decode(responsePatientDetails.body);
          patientCareTeam = json.decode(responseCareTeam.body);

          patientData = responseData['patientData'];
          patientCountry = responseData['patientCountry'];
          patientState = responseData['patientState'];
          patientCity = responseData['patientCity'];
          patientBrgy = responseData['patientBrgy'];

          // Ensure the correct type for patientPrescriptions
          if (responseCommunityPosts.statusCode == 200) {
            final decodedData = json.decode(responseCommunityPosts.body);

            if (decodedData is List) {
              // Explicitly cast each item to Map<String, dynamic>
              communityPosts = List<Map<String, dynamic>>.from(
                decodedData.map<Map<String, dynamic>>(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for prescriptions');
            }
          } else {
            throw Exception('Failed to load patient prescriptions');
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
        future: _fetchPatientProfileFuture,
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
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < smallWidth) {
                      return PatientProfileAppBar(context);
                    } else if (constraints.maxWidth < mediumWidth) {
                      return const SizedBox();
                    } else {
                      return PatientProfileAppBar(context);
                    }
                  },
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < smallWidth) {
                    return SmallScreenPatientProfileBody(
                      patientData,
                      patientCountry,
                      patientState,
                      patientCity,
                      patientBrgy,
                      communityPosts,
                    );
                  } else if (constraints.maxWidth < mediumWidth) {
                    return _buildMediumScreenLayout();
                  } else {
                    return LargeScreenPatientProfileBody(
                      patientData,
                      patientCountry,
                      patientState,
                      patientCity,
                      patientBrgy,
                      patientCareTeam,
                      communityPosts,
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMediumScreenLayout() {
    // Build UI for large screens
    return const Center(
      child: Text('Medium Patient Profile Screen Layout'),
    );
  }

  Widget _buildLargeScreenLayout() {
    // Build UI for large screens
    return const Center(
      child: Text('Large Patient Profile Screen Layout'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_doctor_ui/widgets/Dashboard/LargeScreen/LargeScreenDashboardBody.dart';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/SmallScreen/SmallScreenDashboardBody.dart';
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

  /* Patient Details */
  Map<String, dynamic> responseData = {};
  Map<String, dynamic> patientData = {};
  Map<String, dynamic> patientCountry = {};
  Map<String, dynamic> patientState = {};
  Map<String, dynamic> patientCity = {};
  Map<String, dynamic> patientBrgy = {};
  List<Map<String, dynamic>> patientAllergy = [];

  /* Patient Care Team */
  List<Map<String, dynamic>> careTeam = [];
  List<Map<String, dynamic>> careTeamDoctor = [];
  List<Map<String, dynamic>> careTeamSpecialty = [];
  List<Map<String, dynamic>> careTeamFacility = [];

  /* Patient Appointment */
  Map<String, dynamic> responsePatientAppointment = {};
  Map<String, dynamic> appointment = {};
  Map<String, dynamic> appointmentDoctor = {};
  Map<String, dynamic> appointmentFacility = {};
  Map<String, dynamic> appointmentStatus = {};
  Map<String, dynamic> appointmentReason = {};

  /* Patient Prescriptions */
  Map<String, dynamic> medicationDoctor = {};
  Map<String, dynamic> medicationFacility = {};
  List<Map<String, dynamic>> medicationRequests = [];

  /* Patient Encounters */
  Map<String, dynamic> encounterDoctor = {};
  Map<String, dynamic> encounterFacility = {};
  List<Map<String, dynamic>> patientEncounters = [];
  List<Map<String, dynamic>> pastVisits = [];

  /*Layout Builder Parameters */
  double smallWidth = 600;
  double mediumWidth = 1000;

  @override
  void initState() {
    super.initState();
    _fetchDashboardFuture = _fetchDashboard();
  }

  Future<void> _fetchDashboard() async {
    String patientDetailsURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_details/$globalId';
    String careTeamURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_care_team/$globalId';
    String appointmentURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_appointment/$globalId';
    String prescriptionsURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_prescriptions/$globalId';
    String encountersURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_encounters/$globalId';

    try {
      final responsePatientDetails =
          await http.get(Uri.parse(patientDetailsURL));
      final responseCareTeam = await http.get(Uri.parse(careTeamURL));
      final responseAppointment = await http.get(Uri.parse(appointmentURL));
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
          'Response Status Patient Appointment Code: ${responseAppointment.statusCode}');
      print('Response Patient Appointment Body: ${responseAppointment.body}');

      print(
          'Response Status Patient Prescriptions Code: ${responsePrescriptions.statusCode}');
      print(
          'Response Patient Prescriptions Body: ${responsePrescriptions.body}');

      print(
          'Response Status Patient Encounters Code: ${responseEncounters.statusCode}');
      print('Response Patient Encounters Body: ${responseEncounters.body}');

      if (responsePatientDetails.statusCode == 200) {
        setState(() {
          /* Patient Details */
          if (responsePatientDetails.statusCode == 200) {
            final decodedData = json.decode(responsePatientDetails.body);

            patientData = decodedData['patientData'];
            patientCountry = decodedData['patientCountry'];
            patientState = decodedData['patientState'];
            patientCity = decodedData['patientCity'];
            patientBrgy = decodedData['patientBrgy'];

            if (decodedData['patientAllergy'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              patientAllergy = List<Map<String, dynamic>>.from(
                decodedData['patientAllergy'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for care team');
            }
          }

          /* Patient CareTeam */
          if (responseCareTeam.statusCode == 200) {
            final decodedData = json.decode(responseCareTeam.body);

            if (decodedData['careTeam'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              careTeam = List<Map<String, dynamic>>.from(
                decodedData['careTeam'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for care team');
            }

            if (decodedData['careTeamDoctor'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              careTeamDoctor = List<Map<String, dynamic>>.from(
                decodedData['careTeamDoctor'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for care team doctor');
            }

            if (decodedData['careTeamSpecialty'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              careTeamSpecialty = List<Map<String, dynamic>>.from(
                decodedData['careTeamSpecialty'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for care team doctor');
            }

            if (decodedData['careTeamFacility'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              careTeamFacility = List<Map<String, dynamic>>.from(
                decodedData['careTeamFacility'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for care team facility');
            }
          } else {
            throw Exception('Failed to load patient care team');
          }

          /* Patient Appointment */

          responsePatientAppointment = json.decode(responseAppointment.body);
          appointment = responsePatientAppointment['appointment'];
          appointmentDoctor = responsePatientAppointment['appointmentDoctor'];
          appointmentFacility =
              responsePatientAppointment['appointmentFacility'];
          appointmentStatus = responsePatientAppointment['appointmentStatus'];
          appointmentReason = responsePatientAppointment['appointmentReason'];

          /* Patient Prescriptions */
          if (responsePrescriptions.statusCode == 200) {
            final decodedData = json.decode(responsePrescriptions.body);

            medicationDoctor = decodedData['medicationDoctor'];
            medicationFacility = decodedData['medicationFacility'];

            if (decodedData['medicationRequests'] is List) {
              // Ensure that medicationRequests is a List<Map<String, dynamic>>
              medicationRequests = List<Map<String, dynamic>>.from(
                decodedData['medicationRequests'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );

              print('MedicationRequest: ${medicationRequests}');
            } else {
              throw Exception('Invalid data format for prescriptions');
            }

            if (decodedData['medicationRequests'] is List) {
              // Ensure that medicationRequests is a List<Map<String, dynamic>>
              medicationRequests = List<Map<String, dynamic>>.from(
                decodedData['medicationRequests'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );

              print('MedicationRequest: ${medicationRequests}');
            } else {
              throw Exception('Invalid data format for prescriptions');
            }
          } else {
            throw Exception('Failed to load patient prescriptions');
          }

          /* Patient Past Visits */
          if (responseEncounters.statusCode == 200) {
            final decodedData = json.decode(responseEncounters.body);

            encounterDoctor = decodedData['encounterDoctor'];
            encounterFacility = decodedData['encounterFacility'];

            if (decodedData['patientEncounters'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              patientEncounters = List<Map<String, dynamic>>.from(
                decodedData['patientEncounters'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for past visits');
            }

            if (decodedData['pastVisits'] is List) {
              // Ensure that pastVisits is a List<Map<String, dynamic>>
              pastVisits = List<Map<String, dynamic>>.from(
                decodedData['pastVisits'].map(
                  (item) => item is Map<String, dynamic> ? item : {},
                ),
              );
            } else {
              throw Exception('Invalid data format for past visits');
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

  Future<void> _logout() async {
    String logoutURL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/logout';
    try {
      final responsePatientDetails = await http.get(Uri.parse(logoutURL));
    } catch (e) {
      print('Error: $e');
    }
  }

  int _selectedIndex = 0;

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
              drawer: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < smallWidth) {
                      // Small screen layout
                      return NavBar(_logout);
                    } else if (constraints.maxWidth < mediumWidth) {
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < smallWidth) {
                      // Small screen layout
                      return CustomAppBar(
                          context, patientData, _fetchDashboard);
                    } else if (constraints.maxWidth < mediumWidth) {
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              bottomNavigationBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < smallWidth) {
                      // Small screen layout
                      return const CustomBottomNav();
                    } else if (constraints.maxWidth < mediumWidth) {
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  // Check the screen width and adjust the layout accordingly
                  if (constraints.maxWidth < smallWidth) {
                    // Small screen layout
                    return SmallScreenDashboardBody(
                      patientData,
                      careTeam,
                      careTeamDoctor,
                      careTeamSpecialty,
                      careTeamFacility,
                      appointment,
                      appointmentDoctor,
                      appointmentFacility,
                      appointmentStatus,
                      appointmentReason,
                      medicationDoctor,
                      medicationFacility,
                      medicationRequests,
                      encounterDoctor,
                      encounterFacility,
                      patientEncounters,
                      pastVisits,
                    );
                  } else if (constraints.maxWidth < mediumWidth) {
                    return _buildMediumScreenLayout();
                  } else {
                    return LargeScreenDashboardBody(
                      patientData,
                      patientCountry,
                      patientState,
                      patientCity,
                      patientBrgy,
                      patientAllergy,
                      careTeam,
                      careTeamDoctor,
                      careTeamSpecialty,
                      careTeamFacility,
                      appointment,
                      appointmentDoctor,
                      appointmentFacility,
                      appointmentStatus,
                      appointmentReason,
                      medicationDoctor,
                      medicationFacility,
                      medicationRequests,
                      encounterDoctor,
                      encounterFacility,
                      patientEncounters,
                      pastVisits,
                      onDestinationSelected,
                      _logout,
                    );
                  }
                },
              ),
            ); // Replace with your actual UI
          }
        },
      ),
    );
  }

  onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMediumScreenLayout() {
    // Build UI for large screens
    return const Center(
      child: Text('Medium Dashboard Screen Layout'),
    );
  }

  Widget _buildLargeScreenLayout() {
    // Build UI for large screens
    return const Center(
      child: Text('Large Dashboard Screen Layout'),
    );
  }
}

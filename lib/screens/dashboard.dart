import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_doctor_ui/widgets/CustomAppBar.dart';
import 'package:flutter_doctor_ui/widgets/CustomBottomNav.dart';
import 'package:flutter_doctor_ui/widgets/CustomButton.dart';
import 'package:flutter_doctor_ui/widgets/NavBar.dart';

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
              body: ListView(
                padding: const EdgeInsets.only(top: 20.0, left: 15.0),
                children: [
                  /* Welcome - Start */
                  const Padding(
                    padding: EdgeInsets.only(top: 0.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, " +
                                  '${patientData['first_name']}', // Dynamic Variable
                              style: const TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
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
                          'assets/images/JPG/stethoscope.jpg',
                          height: 120, // Aspect Ratio 3:2
                          width: 180,
                        ),
                      ),
                    ],
                  ),
                  /* Welcome - End */
                  /* My Care Team Card - Start */
                  (!patientCareTeam.containsKey('error'))
                      ? Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                            bottom: 15.0,
                            right: 18.0,
                          ),
                          margin: const EdgeInsets.only(
                            top: 40.0,
                            bottom: 10.0,
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF4454C3).withOpacity(0.25),
                                blurRadius: 4, // Spread radius
                                offset: const Offset(2, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "My Care Team",
                                      style: TextStyle(
                                        color: Color(0xFF424E79),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      '${patientCareTeam['doctor_title']}',
                                      style: const TextStyle(
                                        color: Color(0xFF424E79),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.medical_services_outlined,
                                              color: Color(0xFF424E79),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${patientCareTeam['doctor_profession']}',
                                              style: const TextStyle(
                                                color: Color(0xFF424E79),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3.0),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Color(0xFF424E79),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${patientCareTeam['facility_name']}',
                                              style: const TextStyle(
                                                color: Color(0xFF424E79),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15.0),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomButton(
                                          text: "Book",
                                          onPress: () {},
                                          height: 20.0,
                                          width: 50.0,
                                          fontSize: 12,
                                          fontColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          buttonColor: Color(0xFF4454C3),
                                          buttonOutline: Color(0xFF4454C3),
                                        ),
                                        const SizedBox(width: 8),
                                        CustomButton(
                                          text: "Profile",
                                          onPress: () {},
                                          height: 20.0,
                                          width: 50.0,
                                          fontSize: 12,
                                          fontColor: Color(0xFF4454C3),
                                          buttonColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          buttonOutline: Color(0xFF4454C3),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF4454C3)
                                          .withOpacity(0.25),
                                      blurRadius: 4,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: const Color(0xFF4454C3)
                                        .withOpacity(0.50),
                                    width: 0.5,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    '${patientCareTeam['doctor_image']}', // Dynamic Variable
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                            bottom: 15.0,
                            right: 18.0,
                          ),
                          margin: const EdgeInsets.only(
                            top: 40.0,
                            bottom: 10.0,
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF4454C3).withOpacity(0.25),
                                blurRadius: 4, // Spread radius
                                offset: const Offset(2, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "My Care Team",
                                style: TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "There's no one here",
                                        style: TextStyle(
                                          color: Color(0xFF424E79),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        "Book a Consultation",
                                        style: TextStyle(
                                          color: Color(0xFF424E79),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/images/PNG/info_doctor.png',
                                    height: 140,
                                    width: 140,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                  /* My Care Team Card - End */
                  /* My Prescriptions - Start */
                  patientPrescriptions.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                            bottom: 15.0,
                            right: 18.0,
                          ),
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF4454C3).withOpacity(0.25),
                                blurRadius: 4, // Spread radius
                                offset: const Offset(2, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "My Prescriptions",
                                      style: TextStyle(
                                        color: Color(0xFF424E79),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to All Prescriptions Page
                                      },
                                      child: const Text(
                                        "View All",
                                        style: TextStyle(
                                          color: Color(0xFF4454C3),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              for (var prescription in patientPrescriptions)
                                ListTile(
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      // First Prescription
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          alignment: Alignment.centerLeft,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                              'assets/images/JPG/RX.jpg',
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${prescription['doctor_title']}',
                                                style: const TextStyle(
                                                  color: Color(0xFF424E79),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(
                                                '${prescription['facility_name']}',
                                                style: const TextStyle(
                                                  color: Color(0xFF424E79),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.medication_outlined,
                                                    color: Color(0xFF424E79),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '${prescription['medicine']}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF424E79),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .medical_information_outlined,
                                                    color: Color(0xFF424E79),
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '${prescription['sig']}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF424E79),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    softWrap: true,
                                                    overflow: TextOverflow
                                                        .ellipsis, // Handle overflow with ellipsis
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8.0),
                                              Row(
                                                children: [
                                                  CustomButton(
                                                    text: "View Details",
                                                    onPress: () {},
                                                    height: 20.0,
                                                    width: 50.0,
                                                    fontSize: 12,
                                                    fontColor:
                                                        Color(0xFF4454C3),
                                                    buttonColor: Colors.white,
                                                    buttonOutline:
                                                        Color(0xFF4454C3),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              // You can use SizedBox for additional spacing if needed
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                            bottom: 15.0,
                            right: 18.0,
                          ),
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 20.0,
                          ),
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(8),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color:
                          //           const Color(0xFF4454C3).withOpacity(0.25),
                          //       blurRadius: 4, // Spread radius
                          //       offset: const Offset(2, 2),
                          //     ),
                          //   ],
                          //   border: Border.all(
                          //     color: const Color(0xFF4454C3).withOpacity(0.15),
                          //     width: .5,
                          //   ),
                          // ),
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const Text(
                          //       "My Prescriptions",
                          //       style: TextStyle(
                          //         color: Color(0xFF424E79),
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                  /* My Prescriptions - End */
                  /* My Past Visits - Start */

                  patientPrescriptions.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                            bottom: 15.0,
                            right: 18.0,
                          ),
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 20.0,
                            right: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF4454C3).withOpacity(0.25),
                                blurRadius: 4, // Spread radius
                                offset: const Offset(2, 2),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "My Past Visits",
                                      style: TextStyle(
                                        color: Color(0xFF424E79),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to All Prescriptions Page
                                      },
                                      child: const Text(
                                        "View All",
                                        style: TextStyle(
                                          color: Color(0xFF4454C3),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              for (var encounter in patientEncounters)
                                ListTile(
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: const Color(0xFF4454C3),
                                              width: 2.5,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                              '${encounter['doctor_image']}', // Dynamic Variable
                                              height: 70,
                                              width: 70,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${encounter['facility_name']}',
                                                style: const TextStyle(
                                                  color: Color(0xFF424E79),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(
                                                '${encounter['doctor_title']}',
                                                style: const TextStyle(
                                                  color: Color(0xFF424E79),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                '"' +
                                                    '${encounter['reason']}' +
                                                    '"',
                                                style: const TextStyle(
                                                  color: Color(0xFF424E79),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                '${encounter['time']}',
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 152, 152, 152),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              Row(
                                                children: [
                                                  CustomButton(
                                                    text: "View Details",
                                                    onPress: () {},
                                                    height: 20.0,
                                                    width: 50.0,
                                                    fontSize: 12,
                                                    fontColor:
                                                        Color(0xFF4454C3),
                                                    buttonColor: Colors.white,
                                                    buttonOutline:
                                                        Color(0xFF4454C3),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 18.0,
                            bottom: 15.0,
                            right: 18.0,
                          ),
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            right: 20.0,
                          ),
                          // decoration: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(8),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color:
                          //           const Color(0xFF4454C3).withOpacity(0.25),
                          //       blurRadius: 4, // Spread radius
                          //       offset: const Offset(2, 2),
                          //     ),
                          //   ],
                          //   border: Border.all(
                          //     color: const Color(0xFF4454C3).withOpacity(0.15),
                          //     width: .5,
                          //   ),
                          // ),
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     const Text(
                          //       "My Prescriptions",
                          //       style: TextStyle(
                          //         color: Color(0xFF424E79),
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                  /* My Past Visits - End */
                ],
              ),
            ); // Replace with your actual UI
          }
        },
      ),
    );
  }
}

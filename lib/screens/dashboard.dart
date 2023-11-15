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
  Map<String, dynamic> patientData = {};

  /* Patient Variables */
  String patient_one_image = "assets/images/JPG/patient_one.jpg";
  String patient_firstname = "Luke";

  /* Prescription Variables */
  String patient_medication_one = "Ibuprofen (Fevral) Tablet";
  String medication_sig_one = "2 tablets every 6 hours as needed for...";
  String patient_medication_two = "Bioflu Biogesic Paracetaol";
  String medication_sig_two = "1 Tablet every 4 hours";

  /* Doctor and Facility Variables */
  String doctor_one_image = "assets/images/JPG/doctor_one.jpg";
  String doctor_title = "Abraham Smith M.D,";
  String doctor_profession = "Family Doctor";
  String Health_facility = "Jehovah Rapha Hospital";

  /* Past Visit Variables */
  String consultation_reason_one = "My head hurts when I wake up";
  String time_ago_one = "3 days, 5 hours ago";
  String consultation_reason_two = "I can't sleep properly";
  String time_ago_two = "2 weeks, 5 days ago";

  @override
  void initState() {
    super.initState();
    _fetchPatientProfile();
  }

  Future<void> _fetchPatientProfile() async {
    String url =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientDetails/${globalId}';

    try {
      final response = await http.get(Uri.parse(url));

      // Handle the response
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          patientData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load patient profile');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: const NavBar(),
      appBar: CustomAppBar(context),
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
                        fontSize: 39,
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
          Container(
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
                  color: const Color(0xFF4454C3).withOpacity(0.25),
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
                        doctor_title,
                        style: const TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                doctor_profession,
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
                                Health_facility,
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
                            fontColor: Color.fromARGB(255, 255, 255, 255),
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
                            buttonColor: Color.fromARGB(255, 255, 255, 255),
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
                        color: const Color(0xFF4454C3).withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xFF4454C3).withOpacity(0.50),
                      width: 0.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      doctor_one_image, // Dynamic Variable
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* My Care Team Card - End */
          /* My Prescriptions - Start */
          Container(
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
                  color: const Color(0xFF4454C3).withOpacity(0.25),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
                  // First Prescription
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/JPG/RX.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor_title,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            Health_facility,
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
                                patient_medication_one,
                                style: const TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.medical_information_outlined,
                                color: Color(0xFF424E79),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                medication_sig_one,
                                style: const TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
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
                                fontColor: Color(0xFF4454C3),
                                buttonColor: Colors.white,
                                buttonOutline: Color(0xFF4454C3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  // Second Prescription
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/JPG/RX.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor_title,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            Health_facility,
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
                                patient_medication_two,
                                style: const TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.medical_information_outlined,
                                color: Color(0xFF424E79),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                medication_sig_two,
                                style: const TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
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
                                fontColor: Color(0xFF4454C3),
                                buttonColor: Colors.white,
                                buttonOutline: Color(0xFF4454C3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ), // You can use SizedBox for additional spacing if needed
              ],
            ),
          ),
          /* My Prescriptions - End */
          /* My Past Visits - Start */
          Container(
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
                  color: const Color(0xFF4454C3).withOpacity(0.25),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
                  // Past Visit 1
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color(0xFF4454C3),
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          doctor_one_image, // Dynamic Variable
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Health_facility,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            doctor_title,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            '"' + consultation_reason_one + '"',
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            time_ago_one,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152),
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
                                fontColor: Color(0xFF4454C3),
                                buttonColor: Colors.white,
                                buttonOutline: Color(0xFF4454C3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  // Past Visit 1
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color(0xFF4454C3),
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          doctor_one_image, // Dynamic Variable
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Health_facility,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            doctor_title,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            '"' + consultation_reason_two + '"',
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            time_ago_two,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152),
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
                                fontColor: Color(0xFF4454C3),
                                buttonColor: Colors.white,
                                buttonOutline: Color(0xFF4454C3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          /* My Past Visits - End */
        ],
      ),
    );
  }
}

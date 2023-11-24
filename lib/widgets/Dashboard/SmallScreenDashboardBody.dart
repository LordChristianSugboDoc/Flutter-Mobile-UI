import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomButton.dart';

class SmallScreenDashboardBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> patientCareTeam;
  final List<Map<String, dynamic>> patientPrescriptions;
  final List<Map<String, dynamic>> patientEncounters;

  const SmallScreenDashboardBody(this.patientData, this.patientCareTeam,
      this.patientPrescriptions, this.patientEncounters, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    "Hello, " '${patientData['first_name']}', // Dynamic Variable
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                          const SizedBox(height: 15.0),
                          Text(
                            '${patientCareTeam['doctor_title']}',
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 15.0),
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
                                fontColor: const Color.fromARGB(255, 255, 255, 255),
                                buttonColor: const Color(0xFF4454C3),
                                buttonOutline: const Color(0xFF4454C3),
                              ),
                              const SizedBox(width: 8),
                              CustomButton(
                                text: "Profile",
                                onPress: () {},
                                height: 20.0,
                                width: 50.0,
                                fontSize: 12,
                                fontColor: const Color(0xFF4454C3),
                                buttonColor: const Color.fromARGB(255, 255, 255, 255),
                                buttonOutline: const Color(0xFF4454C3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                    for (var prescription in patientPrescriptions)
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            // First Prescription
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                          '${prescription['sig']}',
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
                                          fontColor: const Color(0xFF4454C3),
                                          buttonColor: Colors.white,
                                          buttonOutline: const Color(0xFF4454C3),
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
                    for (var encounter in patientEncounters)
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
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
                                    '${encounter['doctor_image']}', // Dynamic Variable
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
                                      '"${encounter['reason']}"',
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
                                        color:
                                            Color.fromARGB(255, 152, 152, 152),
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
                                          fontColor: const Color(0xFF4454C3),
                                          buttonColor: Colors.white,
                                          buttonOutline: const Color(0xFF4454C3),
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
    );
  }
}

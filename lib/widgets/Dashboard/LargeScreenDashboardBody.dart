import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/Modals/PatientProfileModal.dart';

import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/Layout/CustomNavigationRail.dart';

class LargeScreenDashboardBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> patientCareTeam;
  final List<Map<String, dynamic>> patientPrescriptions;
  final List<Map<String, dynamic>> patientEncounters;
  final ValueChanged<int> onDestinationSelected;
  final Future<void> Function() logout;

  const LargeScreenDashboardBody(
    this.patientData,
    this.patientCareTeam,
    this.patientPrescriptions,
    this.patientEncounters,
    this.onDestinationSelected,
    this.logout,
  );

  @override
  Widget build(BuildContext context) {
    ExtendNavigationRail extendNavigationRail =
        Provider.of<ExtendNavigationRail>(context);
    double swidth = extendNavigationRail.width;
    double width = MediaQuery.of(context).size.width;

    String firstname = (patientData['firstname'] != null)
        ? patientData['firstname']
        : "Missing";

    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomNavigationRail(
              onDestinationSelected: onDestinationSelected,
              logout: logout,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 00),
                    width: width * swidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Dashboard',
                            style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 35,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Badge(
                                label: Text('4'),
                                child: Icon(
                                  Icons.notifications,
                                  color: Color(0xFF424E79),
                                  size: 35,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PatientProfile.routeName);
                                  // showModal(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 17),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: (patientData['img_url'] != null)
                                        ? Image.network(
                                            'http://10.0.2.2:8080/sugbodoc-multi-tenant/${patientData['img_url']}',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/JPG/default_profile.jpg',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  /* Welcome Card - Start */
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, " '$firstname',
                            style: const TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 45,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          const Text(
                            "How are you feeling today?",
                            style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 28,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/images/JPG/stethoscope.jpg',
                          height: 150, // Aspect Ratio 3:2
                          width: 225,
                        ),
                      ),
                    ],
                  ),
                  /* Welcome Card - End */

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Second Column Starts Here */
                      Column(
                        children: [
                          /* My Care Team - Start */
                          (!patientCareTeam.containsKey('error') &&
                                  patientCareTeam['error'] !=
                                      'Patient Care Team not found')
                              ? Container(
                                  height: 208,
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    left: 18.0,
                                    bottom: 15.0,
                                    right: 18.0,
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 30.0,
                                    bottom: 10.0,
                                    right: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4454C3)
                                            .withOpacity(0.25),
                                        blurRadius: 4, // Spread radius
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color(0xFF4454C3)
                                          .withOpacity(0.15),
                                      width: .5,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "My Care Team",
                                            style: TextStyle(
                                              color: Color(0xFF424E79),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          Text(
                                            '${patientCareTeam['doctor_title']}',
                                            style: const TextStyle(
                                              color: Color(0xFF424E79),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .medical_services_outlined,
                                                    color: Color(0xFF424E79),
                                                    size: 30,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '${patientCareTeam['doctor_profession']}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF424E79),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                    size: 30,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    '${patientCareTeam['facility_name']}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF424E79),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 15.0),
                                              Row(
                                                children: [
                                                  CustomPrimaryButton(
                                                    text: 'Book',
                                                    onPress: () {},
                                                    inputHeight: 35,
                                                    inputWidth: 110,
                                                    fontSize: 17,
                                                    fontColor: Colors.white,
                                                    buttonColor:
                                                        const Color(0xFF4454C3),
                                                    buttonOutline:
                                                        const Color(0xFF4454C3),
                                                    outlineWidth: 0,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  CustomPrimaryButton(
                                                    text: 'Profile',
                                                    onPress: () {},
                                                    inputHeight: 35,
                                                    inputWidth: 110,
                                                    fontSize: 17,
                                                    fontColor:
                                                        const Color(0xFF4454C3),
                                                    buttonColor: Colors.white,
                                                    buttonOutline:
                                                        const Color(0xFF4454C3),
                                                    outlineWidth: 3,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 20),
                                        alignment: Alignment.centerRight,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            '${patientCareTeam['doctor_image']}', // Dynamic Variable
                                            height: 135,
                                            width: 135,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 208,
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    left: 18.0,
                                    bottom: 15.0,
                                    right: 18.0,
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 30.0,
                                    bottom: 10.0,
                                    right: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4454C3)
                                            .withOpacity(0.25),
                                        blurRadius: 4, // Spread radius
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color(0xFF4454C3)
                                          .withOpacity(0.15),
                                      width: .5,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "My Care Team",
                                        style: TextStyle(
                                          color: Color(0xFF424E79),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "There's no one here",
                                                style: TextStyle(
                                                  color: Color(0xFF424E79)
                                                      .withOpacity(0.7),
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(
                                                "Book a Consultation",
                                                style: TextStyle(
                                                  color: Color(0xFF424E79)
                                                      .withOpacity(0.5),
                                                  fontSize: 25,
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
                          /* My Care Team - Ends */
                          /* My Prescriptions - Start */
                          patientPrescriptions.isNotEmpty
                              ? Container(
                                  height: 260,
                                  width: 430,
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    left: 18.0,
                                    bottom: 15.0,
                                    right: 18.0,
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 15.0,
                                    bottom: 10.0,
                                    right: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4454C3)
                                            .withOpacity(0.25),
                                        blurRadius: 4, // Spread radius
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color(0xFF4454C3)
                                          .withOpacity(0.15),
                                      width: .5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "My Prescriptions",
                                              style: TextStyle(
                                                color: Color(0xFF424E79),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text(
                                                "View All",
                                                style: TextStyle(
                                                  color: Color(0xFF4454C3),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            for (var prescription
                                                in patientPrescriptions)
                                              Container(
                                                width: 400,
                                                child: ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Row(
                                                      // First Prescription
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 0),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: Image.asset(
                                                              'assets/images/JPG/RX.jpg',
                                                              height: 75,
                                                              width: 75,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${prescription['doctor_title']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF424E79),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${prescription['facility_name']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF424E79),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8.0),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .medication_outlined,
                                                                    color: Color(
                                                                        0xFF424E79),
                                                                    size: 20,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Text(
                                                                    '${prescription['medicine']}',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xFF424E79),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .medical_information_outlined,
                                                                    color: Color(
                                                                        0xFF424E79),
                                                                    size: 20,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 8),
                                                                  Text(
                                                                    '${prescription['sig']}',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xFF424E79),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    softWrap:
                                                                        true,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 14.0),
                                                              Row(
                                                                children: [
                                                                  CustomPrimaryButton(
                                                                    text:
                                                                        'View Details',
                                                                    onPress:
                                                                        () {},
                                                                    inputHeight:
                                                                        35,
                                                                    inputWidth:
                                                                        150,
                                                                    fontSize:
                                                                        17,
                                                                    fontColor:
                                                                        const Color(
                                                                            0xFF4454C3),
                                                                    buttonColor:
                                                                        Colors
                                                                            .white,
                                                                    buttonOutline:
                                                                        const Color(
                                                                            0xFF4454C3),
                                                                    outlineWidth:
                                                                        3,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
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
                        ],
                      ),
                      /* Second Col Ends Here */

                      /* Third Col Starts Here */
                      Column(
                        children: [
                          /* Upcoming Appointments - Start */
                          Container(
                            height: 208,
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              left: 18.0,
                              bottom: 15.0,
                              right: 18.0,
                            ),
                            margin: const EdgeInsets.only(
                              top: 30.0,
                              bottom: 10.0,
                              right: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF4454C3).withOpacity(0.25),
                                  blurRadius: 4, // Spread radius
                                  offset: const Offset(2, 2),
                                ),
                              ],
                              border: Border.all(
                                color:
                                    const Color(0xFF4454C3).withOpacity(0.15),
                                width: .5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // const Text(
                                //   "Upcoming Appointments",
                                //   style: TextStyle(
                                //     color: Color(0xFF424E79),
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "You have No Appointments",
                                          style: TextStyle(
                                            color: Color(0xFF424E79)
                                                .withOpacity(0.7),
                                            fontSize: 23,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          "Try Booking a Consultation",
                                          style: TextStyle(
                                            color: Color(0xFF424E79)
                                                .withOpacity(0.5),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'assets/images/PNG/Doctor_Calendar.png',
                                      height: 150,
                                      width: 185,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /* Upcoming Appointments - End */
                          /* My Past Visits - Start */
                          patientPrescriptions.isNotEmpty
                              ? Container(
                                  height: 290,
                                  width: 505,
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                    left: 18.0,
                                    bottom: 15.0,
                                    right: 18.0,
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 15.0,
                                    bottom: 10.0,
                                    right: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4454C3)
                                            .withOpacity(0.25),
                                        blurRadius: 4, // Spread radius
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color(0xFF4454C3)
                                          .withOpacity(0.15),
                                      width: .5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "My Past Visits",
                                              style: TextStyle(
                                                color: Color(0xFF424E79),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text(
                                                "View All",
                                                style: TextStyle(
                                                  color: Color(0xFF4454C3),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            for (var encounter
                                                in patientEncounters)
                                              Container(
                                                width: 440,
                                                child: ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xFF4454C3),
                                                              width: 2.5,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: Image.asset(
                                                              '${encounter['doctor_image']}', // Dynamic Variable
                                                              height: 110,
                                                              width: 110,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${encounter['facility_name']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF424E79),
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${encounter['doctor_title']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF424E79),
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20.0),
                                                              Text(
                                                                '"${encounter['reason']}"',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFF424E79),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 2.0),
                                                              Text(
                                                                '${encounter['time']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          152,
                                                                          152,
                                                                          152),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20.0),
                                                              Row(
                                                                children: [
                                                                  CustomPrimaryButton(
                                                                    text:
                                                                        'View Details',
                                                                    onPress:
                                                                        () {},
                                                                    inputHeight:
                                                                        40,
                                                                    inputWidth:
                                                                        200,
                                                                    fontSize:
                                                                        20,
                                                                    fontColor:
                                                                        const Color(
                                                                            0xFF4454C3),
                                                                    buttonColor:
                                                                        Colors
                                                                            .white,
                                                                    buttonOutline:
                                                                        const Color(
                                                                            0xFF4454C3),
                                                                    outlineWidth:
                                                                        3,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
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
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return Center(
          child: PatientProfileModal(patientData),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/PastEncountersContainer.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/PrescriptionContainer.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/Modals/PatientProfileModal.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/Layout/CustomNavigationRail.dart';

class LargeScreenDashboardBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> careTeam;
  final Map<String, dynamic> careTeamDoctor;
  final Map<String, dynamic> careTeamFacility;
  final Map<String, dynamic> appointment;
  final Map<String, dynamic> appointmentDoctor;
  final Map<String, dynamic> appointmentFacility;
  final Map<String, dynamic> appointmentStatus;
  final Map<String, dynamic> appointmentReason;
  final Map<String, dynamic> medicationDoctor;
  final Map<String, dynamic> medicationFacility;
  final List<Map<String, dynamic>> medicationRequests;
  final Map<String, dynamic> encounterDoctor;
  final Map<String, dynamic> encounterFacility;
  final List<Map<String, dynamic>> patientEncounters;
  final List<Map<String, dynamic>> pastVisits;
  final ValueChanged<int> onDestinationSelected;
  final Future<void> Function() logout;

  const LargeScreenDashboardBody(
    this.patientData,
    this.careTeam,
    this.careTeamDoctor,
    this.careTeamFacility,
    this.appointment,
    this.appointmentDoctor,
    this.appointmentFacility,
    this.appointmentStatus,
    this.appointmentReason,
    this.medicationDoctor,
    this.medicationFacility,
    this.medicationRequests,
    this.encounterDoctor,
    this.encounterFacility,
    this.patientEncounters,
    this.pastVisits,
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

    final Color appointmentColor;

    if (appointmentStatus['hl7_code'] == 'proposed' ||
        appointmentStatus['hl7_code'] == 'pending') {
      appointmentColor = Color.fromARGB(255, 226, 204, 0).withOpacity(0.9);
    } else if (appointmentStatus['hl7_code'] == 'cancelled' ||
        appointmentStatus['hl7_code'] == 'entered-in-error' ||
        appointmentStatus['hl7_code'] == 'noshow') {
      appointmentColor = Colors.red.withOpacity(0.8);
    } else if (appointmentStatus['hl7_code'] == 'checked-in' ||
        appointmentStatus['hl7_code'] == 'waitlist') {
      appointmentColor = Colors.black.withOpacity(0.7);
    } else {
      appointmentColor = Color(0xFF4454C3).withOpacity(1.00);
    }

    final int length = patientEncounters.length;

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
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Use the default image if loading the image fails
                                              return Image.asset(
                                                'assets/images/JPG/default_profile.jpg',
                                                height: 135,
                                                width: 135,
                                              );
                                            },
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
                            "Hello, "
                            '$firstname',
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
                          (!careTeam.containsKey('error') ||
                                  careTeam['error'] !=
                                      'Patient Care Team not found')
                              ? Container(
                                  // height: 208,
                                  width: 430,
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
                                            '${careTeamDoctor['professional_display_name']}',
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
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .medical_services_outlined,
                                                    color: Color(0xFF424E79),
                                                    size: 30,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Consultant Physician',
                                                    style: TextStyle(
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
                                                    '${careTeamFacility['name']}',
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
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: (careTeamDoctor['img_url'] !=
                                                    null)
                                                ? Image.network(
                                                    'http://10.0.2.2:8080/sugbodoc-multi-tenant/${careTeamDoctor['img_url']}', // Dynamic Variable
                                                    height: 135,
                                                    width: 135,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      // Use the default image if loading the image fails
                                                      return Image.asset(
                                                        'assets/images/JPG/default_profile.jpg',
                                                        height: 135,
                                                        width: 135,
                                                      );
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/images/JPG/default_profile.jpg', // Dynamic Variable
                                                    height: 135,
                                                    width: 135,
                                                  ),
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
                          medicationRequests.isNotEmpty
                              ? PrescriptionContainer(
                                  cardWidth: 430,
                                  cardHeight: 260,
                                  containerWidth: 400,
                                  medicationDoctor: medicationDoctor,
                                  medicationFacility: medicationFacility,
                                  medicationRequests: medicationRequests
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                )
                              : Container(),
                          /* My Prescriptions - End */
                        ],
                      ),
                      /* Second Col Ends Here */

                      /* Third Col Starts Here */
                      Column(
                        children: [
                          /* Upcoming Appointments - Start */
                          (!appointment.containsKey('error') &&
                                  appointment['error'] !=
                                      'Patient Appointment not found' &&
                                  appointmentStatus['hl7_code'] != "fulfilled")
                              ? GestureDetector(
                                  onTap: () async {
                                    String liveMeetingLink =
                                        (appointmentStatus['hl7_code'] ==
                                                "booked")
                                            ? appointment['live_meeting_link']
                                            : null;

                                    try {
                                      await launch(
                                        liveMeetingLink,
                                        forceWebView: true, // Open in a WebView
                                        enableJavaScript:
                                            true, // Enable JavaScript in the WebView, if needed
                                      );
                                    } catch (e) {
                                      print("Error launching URL: $e");
                                    }
                                  },
                                  child: Container(
                                    height: 208,
                                    width: 505,
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
                                          color: appointmentColor,
                                          blurRadius: 4, // Spread radius
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: const Color(0xFF4454C3)
                                            .withOpacity(0.15),
                                        width: .5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Upcoming Appointment",
                                              style: TextStyle(
                                                color: Color(0xFF424E79),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '${appointmentStatus['patient_display_name']}',
                                                style: TextStyle(
                                                  color: appointmentColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 0),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                                0xFF4454C3)
                                                            .withOpacity(0.25),
                                                        blurRadius: 4,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: const Color(
                                                              0xFF4454C3)
                                                          .withOpacity(0.50),
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: (careTeamDoctor[
                                                                  'img_url'] !=
                                                              null)
                                                          ? Image.network(
                                                              'http://10.0.2.2:8080/sugbodoc-multi-tenant/${appointmentDoctor['img_url']}', // Dynamic Variable
                                                              height: 115,
                                                              width: 115,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                // Use the default image if loading the image fails
                                                                return Image
                                                                    .asset(
                                                                  'assets/images/JPG/default_profile.jpg',
                                                                  height: 115,
                                                                  width: 115,
                                                                );
                                                              },
                                                            )
                                                          : Image.asset(
                                                              'assets/images/JPG/default_profile.jpg', // Dynamic Variable
                                                              height: 115,
                                                              width: 115,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 18,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      '${appointmentDoctor['professional_display_name']}',
                                                      style: TextStyle(
                                                        color: Color(0xFF424E79)
                                                            .withOpacity(1.0),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${appointmentFacility['name']}',
                                                      style: TextStyle(
                                                        color: Color(0xFF424E79)
                                                            .withOpacity(0.7),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '"${appointmentReason['appointment_reason_text']}"',
                                                      style: TextStyle(
                                                        color: Color(0xFF424E79)
                                                            .withOpacity(0.5),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '${appointment['time_slot']}',
                                                      style: TextStyle(
                                                        color: Color(0xFF424E79)
                                                            .withOpacity(1.0),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 208,
                                  width: 505,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
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
                                            width: 175,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                          /* Upcoming Appointments - End */
                          /* My Past Visits - Start */
                          pastVisits.isNotEmpty
                              ? PastEncountersContainer(
                                  cardWidth: 505,
                                  cardHeight: 290,
                                  containerWidth: 440,
                                  encounterDoctor: encounterDoctor,
                                  encounterFacility: encounterFacility,
                                  patientEncounters: patientEncounters
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                  pastVisits: pastVisits
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                )
                              : Container(),
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

  String calculateTimeAgo(String dateTimeString) {
    DateTime encounterDate = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(encounterDate);

    if (difference.inDays > 0) {
      return DateFormat.yMMMMd().format(encounterDate);
    } else if (difference.inHours > 0) {
      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;
      String hoursString =
          hours > 0 ? '$hours ${hours == 1 ? 'hour' : 'hours'}' : '';
      String minutesString =
          minutes > 0 ? '$minutes ${minutes == 1 ? 'minute' : 'minutes'}' : '';

      if (hours > 0 && minutes > 0) {
        return '$hoursString and $minutesString ago';
      } else {
        return '$hoursString$minutesString ago';
      }
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}

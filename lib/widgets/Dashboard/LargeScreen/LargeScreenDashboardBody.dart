import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/LargeScreen/MyCareTeamCard.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/LargeScreen/MyPastEncountersCard.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/LargeScreen/MyPrescriptionsCard.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/LargeScreen/UpcomingAppointmentCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_doctor_ui/Modals/PatientProfileModal.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/ExtendNavigationRail.dart';
import 'package:flutter_doctor_ui/widgets/Layout/CustomNavigationRail.dart';

class LargeScreenDashboardBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> patientCountry;
  final Map<String, dynamic> patientState;
  final Map<String, dynamic> patientCity;
  final Map<String, dynamic> patientBrgy;
  final List<Map<String, dynamic>> patientAllergy;
  final List<Map<String, dynamic>> careTeam;
  final List<Map<String, dynamic>> careTeamDoctor;
  final List<Map<String, dynamic>> careTeamSpecialty;
  final List<Map<String, dynamic>> careTeamFacility;
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
    this.patientCountry,
    this.patientState,
    this.patientCity,
    this.patientBrgy,
    this.patientAllergy,
    this.careTeam,
    this.careTeamDoctor,
    this.careTeamSpecialty,
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
                                  // Navigator.pushNamed(
                                  //     context, PatientProfile.routeName);
                                  showModal(context);
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
                            '${(firstname ?? '').substring(0, 8)}...',
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 45,
                              fontWeight: FontWeight.w500,
                            ),
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
                          careTeam.isNotEmpty
                              ? MyCareTeamCard(
                                  cardWidth: 430,
                                  cardHeight: 239,
                                  containerWidth: 440,
                                  careTeam: careTeam
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                  careTeamDoctor: careTeamDoctor
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                  careTeamSpecialty: careTeamSpecialty
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                  careTeamFacility: careTeamFacility
                                      .map(
                                          (item) => item.cast<String, String>())
                                      .toList(),
                                )
                              : Container(
                                  width: 430,
                                  height: 239,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                  fontSize: 28,
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
                              ? MyPrescriptionsCard(
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
                              : Container(
                                  width: 430,
                                  height: 260,
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
                                                "No Prescriptions",
                                                style: TextStyle(
                                                  color: Color(0xFF424E79)
                                                      .withOpacity(0.7),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(
                                                "Consult your Doctor",
                                                style: TextStyle(
                                                  color: Color(0xFF424E79)
                                                      .withOpacity(0.5),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            'assets/images/PNG/my_prescriptions.png',
                                            height: 160,
                                            width: 160,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          /* My Prescriptions - End */
                        ],
                      ),
                      /* Second Col Ends Here */

                      /* Third Col Starts Here */
                      Column(
                        children: [
                          /* Upcoming Appointments - Start */
                          (appointmentStatus['hl7_code'] != null &&
                                  appointmentStatus['hl7_code'] != "fulfilled")
                              ? UpcomingAppointmentCard(
                                  cardHeight: 239,
                                  cardWidth: 505,
                                  appointment: appointment,
                                  appointmentDoctor: appointmentDoctor,
                                  appointmentFacility: appointmentFacility,
                                  appointmentStatus: appointmentStatus,
                                  appointmentReason: appointmentReason,
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
                              ? MyPastEncountersCard(
                                  cardWidth: 505,
                                  cardHeight: 260,
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
                              : Container(
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
                                                "You have No Records",
                                                style: TextStyle(
                                                  color: Color(0xFF424E79)
                                                      .withOpacity(0.7),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Text(
                                                "Try Consulting your Doctor",
                                                style: TextStyle(
                                                  color: Color(0xFF424E79)
                                                      .withOpacity(0.5),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            'assets/images/PNG/past_visit.png',
                                            height: 180,
                                            width: 180,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: ClipRect(
            // Use ClipRect to remove border radius
            child: Container(
              width: MediaQuery.of(context).size.width * .30,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: PatientProfileModal(
                  patientData,
                  patientCountry,
                  patientState,
                  patientCity,
                  patientBrgy,
                  patientAllergy
                      .map((item) => item.cast<String, String>())
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/SmallScreen/MyCareTeamCard.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/SmallScreen/MyPastEncountersCard.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/SmallScreen/MyPrescriptionsCard.dart';
import 'package:flutter_doctor_ui/widgets/Dashboard/SmallScreen/UpcomingAppointmentCard.dart';

class SmallScreenDashboardBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
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

  const SmallScreenDashboardBody(
      this.patientData,
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
      {super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String firstname = (patientData['firstname'] != null)
        ? patientData['firstname']
        : "Missing";
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
                    "Hello, "
                    '$firstname', // Dynamic Variable
                    style: const TextStyle(
                      color: Color(0xFF424E79),
                      fontSize: 26,
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
        careTeam.isNotEmpty
            ? MyCareTeamCard(
                cardWidth: width * .98,
                cardHeight: height * .24,
                containerWidth: width * .6,
                careTeam: careTeam
                    .map((item) => item.cast<String, String>())
                    .toList(),
                careTeamDoctor: careTeamDoctor
                    .map((item) => item.cast<String, String>())
                    .toList(),
                careTeamSpecialty: careTeamSpecialty
                    .map((item) => item.cast<String, String>())
                    .toList(),
                careTeamFacility: careTeamFacility
                    .map((item) => item.cast<String, String>())
                    .toList(),
              )
            : Container(
                width: width * .98,
                height: height * .23,
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 18.0,
                  bottom: 15.0,
                  right: 18.0,
                ),
                margin: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                  right: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "There's no one here",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.7),
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              "Book a Consultation",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.5),
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
        (appointmentStatus['hl7_code'] != null &&
                appointmentStatus['hl7_code'] != "fulfilled")
            ? UpcomingAppointmentCard(
                cardWidth: width * .98,
                cardHeight: height * .22,
                appointment: appointment,
                appointmentDoctor: appointmentDoctor,
                appointmentFacility: appointmentFacility,
                appointmentStatus: appointmentStatus,
                appointmentReason: appointmentReason,
              )
            : Container(
                width: width * .98,
                height: height * .18,
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
                  borderRadius: BorderRadius.circular(15),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You have No Appointments",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.7),
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              "Try Booking a Consultation",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/PNG/Doctor_Calendar.png',
                          height: 110,
                          width: 125,
                        )
                      ],
                    ),
                  ],
                ),
              ),
        /* My Care Team Card - End */

        /* My Prescriptions - Start */
        medicationRequests.isNotEmpty
            ? MyPrescriptionsCard(
                cardWidth: width * .98,
                cardHeight: height * .26,
                containerWidth: width * .88,
                medicationDoctor: medicationDoctor,
                medicationFacility: medicationFacility,
                medicationRequests: medicationRequests
                    .map((item) => item.cast<String, String>())
                    .toList(),
              )
            : Container(
                width: width * .98,
                height: height * .187,
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
                  borderRadius: BorderRadius.circular(15),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No Prescriptions",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.7),
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              "Consult your Doctor",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.5),
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/PNG/my_prescriptions.png',
                          height: 130,
                          width: 130,
                        )
                      ],
                    ),
                  ],
                ),
              ),
        /* My Prescriptions - End */

        /* My Past Visits - Start */
        patientEncounters.isNotEmpty
            ? MyPastEncountersCard(
                cardWidth: width * .98,
                cardHeight: height * .25,
                containerWidth: width * .88,
                encounterDoctor: encounterDoctor,
                encounterFacility: encounterFacility,
                patientEncounters: patientEncounters
                    .map((item) => item.cast<String, String>())
                    .toList(),
                pastVisits: pastVisits
                    .map((item) => item.cast<String, String>())
                    .toList(),
              )
            : Container(
                width: width * .98,
                height: height * .198,
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
                  borderRadius: BorderRadius.circular(15),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You have No Records",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.7),
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              "Try Consulting your Doctor",
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/PNG/past_visit.png',
                          height: 140,
                          width: 140,
                        )
                      ],
                    ),
                  ],
                ),
              ),
        /* My Past Visits - End */
      ],
    );
  }
}

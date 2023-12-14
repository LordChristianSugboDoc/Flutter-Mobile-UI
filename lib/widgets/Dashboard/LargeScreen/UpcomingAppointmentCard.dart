import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final Map<String, dynamic> appointment;
  final Map<String, dynamic> appointmentDoctor;
  final Map<String, dynamic> appointmentFacility;
  final Map<String, dynamic> appointmentStatus;
  final Map<String, dynamic> appointmentReason;

  UpcomingAppointmentCard({
    required this.cardHeight,
    required this.cardWidth,
    required this.appointment,
    required this.appointmentDoctor,
    required this.appointmentFacility,
    required this.appointmentStatus,
    required this.appointmentReason,
  });

  @override
  Widget build(BuildContext context) {
    final Color appointmentColor;

    if (appointmentStatus['hl7_code'] == 'proposed' ||
        appointmentStatus['hl7_code'] == 'pending') {
      appointmentColor = Color.fromARGB(255, 218, 196, 0).withOpacity(1.0);
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

    return GestureDetector(
      onTap: () async {
        // Changed
        String liveMeetingLink = (appointmentStatus['hl7_code'] == "booked")
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
        height: cardHeight,
        width: cardWidth,
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
            color: const Color(0xFF4454C3).withOpacity(0.15),
            width: .5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 1.0,
                  ), // Add padding of 8.0 to all sides
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: appointmentColor, // Set the color of the border
                      width: 2.5, // Set the width of the border
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${appointmentStatus['patient_display_name']}',
                    style: TextStyle(
                      color: appointmentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      margin: const EdgeInsets.only(top: 20, left: 0),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
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
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: (appointmentDoctor['img_url'] != null)
                              ? Image.network(
                                  'http://10.0.2.2:8080/sugbodoc-multi-tenant/${appointmentDoctor['img_url']}', // Dynamic Variable
                                  height: 140,
                                  width: 140,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Use the default image if loading the image fails
                                    return Image.asset(
                                      'assets/images/JPG/default_profile.jpg',
                                      height: 140,
                                      width: 140,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/JPG/default_profile.jpg', // Dynamic Variable
                                  height: 140,
                                  width: 140,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${appointmentDoctor['professional_display_name']}',
                          style: TextStyle(
                            color: Color(0xFF424E79).withOpacity(1.0),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${appointmentFacility['name']}',
                          style: TextStyle(
                            color: Color(0xFF424E79).withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xFF424E79),
                              size: 28,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              '${appointment['appointment_date']}',
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(1.0),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Color(0xFF424E79),
                              size: 28,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              '${appointment['time_slot']}',
                              style: TextStyle(
                                color: Color(0xFF424E79).withOpacity(1.0),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  static String routeName = "/patientprofile";

  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String facility_role = "Patient";

  /* Personal Details */
  String patient_firstname = "Luke";
  String patient_lastname = "Smith";
  String patient_address = "Cebu City, Cebu";
  String patient_email = "sarah_jrh@mailinator.com";
  String patient_phone = "+639482314212";

  /* Community Card */
  String doctor_one_image = "assets/images/JPG/doctor_one.jpg";
  String doctor_one_title = "Abraham Smith M.D,";
  String doctor_one_message = "Remember to take your Medicine Daily";

  String doctor_two_image = "assets/images/JPG/doctor_three.jpg";
  String doctor_two_title = "Daniel Lee M.D,";
  String doctor_two_message = "Live as best as you can Manage";

  String doctor_three_image = "assets/images/JPG/doctor_two.jpg";
  String doctor_three_title = "Rachel Scott M.D,";
  String doctor_three_message = "Remember to get at least 7 hours of sleep";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        iconTheme: const IconThemeData(
          color: Color(0xFF4454C3),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.border_color_outlined,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/JPG/patient_one.jpg',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              const SizedBox(height: 13.0),
              Text(
                patient_firstname + " " + patient_lastname,
                style: const TextStyle(
                  color: Color(0xFF424E79),
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                facility_role,
                style: const TextStyle(
                  color: Color(0xFF424E79),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),

              /* Messages Card - Start */
              Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 18.0,
                  bottom: 15.0,
                  right: 18.0,
                ),
                margin: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
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
                    const Text(
                      "Personal Details",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      // Name
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name: ",
                          style: TextStyle(
                            color: Color(0xFF424E79),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 36.0),
                        Flexible(
                          child: Text(
                            patient_firstname + " " + patient_lastname,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      // Address
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Address: ",
                          style: TextStyle(
                            color: Color(0xFF424E79),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Flexible(
                          child: Text(
                            patient_address,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      // Email
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email: ",
                          style: TextStyle(
                            color: Color(0xFF424E79),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 39.0),
                        Flexible(
                          child: Text(
                            patient_email,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      // Phone
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Phone: ",
                          style: TextStyle(
                            color: Color(0xFF424E79),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 33.0),
                        Flexible(
                          child: Text(
                            patient_phone,
                            style: const TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
              /* Messages Card - End */
              /* Community - Start */
              Container(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 18.0,
                  bottom: 15.0,
                  right: 18.0,
                ),
                margin: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
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
                    const Text(
                      "Community",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      // First Community Card
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4454C3).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    doctor_one_image, // Dynamic Variable
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 25.0),
                                  Text(
                                    doctor_one_title, // Dynamic Variable
                                    style: const TextStyle(
                                      color: Color(0xFF424E79),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 7.0),
                                  Text(
                                    doctor_one_message, // Dynamic Variable
                                    style: const TextStyle(
                                      color: Color(0xFF424E79),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Column(
                      // Second Community Card
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF4454C3).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    doctor_two_image, // Dynamic Variable
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 25.0),
                                  Text(
                                    doctor_two_title, // Dynamic Variable
                                    style: const TextStyle(
                                      color: Color(0xFF424E79),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 7.0),
                                  Text(
                                    doctor_two_message, // Dynamic Variable
                                    style: const TextStyle(
                                      color: Color(0xFF424E79),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Column(
                      // Second Community Card
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF4454C3).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFF4454C3).withOpacity(0.15),
                              width: .5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    doctor_three_image, // Dynamic Variable
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 25.0),
                                  Text(
                                    doctor_three_title, // Dynamic Variable
                                    style: const TextStyle(
                                      color: Color(0xFF424E79),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 7.0),
                                  Text(
                                    doctor_three_message, // Dynamic Variable
                                    style: const TextStyle(
                                      color: Color(0xFF424E79),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /* Community - End */
            ],
          ),
        ],
      ),
    );
  }
}

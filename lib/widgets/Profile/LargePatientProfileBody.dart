import 'package:flutter/material.dart';

class LargeScreenPatientProfileBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> patientCareTeam;
  final List<Map<String, dynamic>> communityPosts;

  LargeScreenPatientProfileBody(
      this.patientData, this.patientCareTeam, this.communityPosts,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 0.0,
                  bottom: 5.0,
                  left: 35.0,
                  right: 35.0,
                ),
                child: Text(
                  'Patient Profile',
                  style: TextStyle(
                    color: Color(0xFF424E79).withOpacity(0.9),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: width * .99,
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 18.0,
                  bottom: 15.0,
                  right: 18.0,
                ),
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: 35.0,
                  right: 35.0,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (patientData['image'] != null)
                          ? Image.network(
                              'http://10.0.2.2:8080/flutter-mobile-backend-ui/${patientData['image']}',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/JPG/default_profile.jpg',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          '${patientData['first_name']}'
                          " "
                          '${patientData['last_name']}',
                          style: const TextStyle(
                            color: Color(0xFF424E79),
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Facility Role: Patient',
                          style: TextStyle(
                            color: Color(0xFF424E79).withOpacity(0.7),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 175),
                    Container(
                      height: 200,
                      width: .5,
                      color: Color(0xFF424E79).withOpacity(0.5),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Address:',
                                style: TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 55,
                              ),
                              Flexible(
                                child: Text(
                                  '${patientData['address']}, ${patientData['barangay']}, ${patientData['city']}, ${patientData['province']}, ${patientData['country']}',
                                  style: const TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email:',
                                style: TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 78,
                              ),
                              Text(
                                '${patientData['email']}',
                                style: const TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Phone:',
                                style: TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                '${patientData['phone']}',
                                style: const TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * .99,
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 18.0,
                  bottom: 15.0,
                  right: 18.0,
                ),
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: 35.0,
                  right: 35.0,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle the tap gesture here
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.create_rounded,
                                  size: 24,
                                  color: Color(0xFF4454C3),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Edit Patient Profile',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF4454C3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle the tap gesture here
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  size: 24,
                                  color: Color(0xFF4454C3),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF4454C3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle the tap gesture here
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.next_plan,
                                  size: 24,
                                  color: Color(0xFF4454C3),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Choose Plan',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF4454C3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle the tap gesture here
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  size: 24,
                                  color: Color(0xFF4454C3),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Password and Security',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF4454C3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 85,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (!patientCareTeam.containsKey('error'))
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: 40),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Patient Care Team",
                                            style: TextStyle(
                                              color: Color(0xFF424E79),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10, left: 0),
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
                                                    color:
                                                        const Color(0xFF4454C3)
                                                            .withOpacity(0.50),
                                                    width: 0.5,
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.asset(
                                                    '${patientCareTeam['doctor_image']}', // Dynamic Variable
                                                    height: 90,
                                                    width: 90,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    '${patientCareTeam['doctor_title']}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF424E79),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${patientCareTeam['doctor_profession']}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF424E79),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              const Text(
                                "Community Posts",
                                style: TextStyle(
                                  color: Color(0xFF424E79),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              for (var communityPost in communityPosts)
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      .644, // Adjust this width as needed
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, left: 0.0),
                                      child: Column(
                                        // First Community Card
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF4454C3)
                                                  .withOpacity(0.10),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: const Color(0xFF4454C3)
                                                    .withOpacity(0.15),
                                                width: .5,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.asset(
                                                      '${communityPost['doctor_image']}', // Dynamic Variable
                                                      height: 125,
                                                      width: 125,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: 25.0),
                                                    Text(
                                                      '${communityPost['doctor_title']}', // Dynamic Variable
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF424E79),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 7.0),
                                                    Text(
                                                      '${communityPost['message']}', // Dynamic Variable
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF424E79),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

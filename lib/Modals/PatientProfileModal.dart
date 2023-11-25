import 'package:flutter/material.dart';

class PatientProfileModal extends StatelessWidget {
  final Map<String, dynamic> patientData;
  // List<Map<String, dynamic>> communityPosts;

  PatientProfileModal(
    this.patientData,
    // this.communityPosts,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .5,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patient Profile',
                style: TextStyle(
                    color: Color(0xFF424E79),
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.clear_rounded,
                        size: 30,
                        color: Color(0xFF4454C3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: (patientData['image'] != null)
                        ? Image.network(
                            'http://10.0.2.2:8080/flutter-mobile-backend-ui/${patientData['image']}',
                            height: 165,
                            width: 165,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/JPG/default_profile.jpg',
                            height: 165,
                            width: 165,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 170,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 216, 221, 247),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ), // Apply border radius here
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            size: 25,
                            color: Color(0xFF424E79),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name:',
                              style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 75,
                            ),
                            Text(
                              '${patientData['first_name']}'
                              " "
                              '${patientData['last_name']}',
                              style: const TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Facility Role:',
                              style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Patient',
                              style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
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
                            Text(
                              '${patientData['address']}',
                              style: const TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
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
                        const SizedBox(height: 3),
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
              //
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SmallScreenPatientProfileBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final List<Map<String, dynamic>> communityPosts;

  SmallScreenPatientProfileBody(this.patientData, this.communityPosts,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                child: (patientData['image'] != null)
                    ? Image.network(
                        'http://10.0.2.2:8080/flutter-mobile-backend-ui/${patientData['image']}',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/JPG/default_profile.jpg',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 13.0),
            Text(
              '${patientData['first_name']}'
              " "
              '${patientData['last_name']}',
              style: const TextStyle(
                color: Color(0xFF424E79),
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2.0),
            const Text(
              'Patient',
              style: TextStyle(
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
                          '${patientData['first_name']}'
                          " "
                          '${patientData['last_name']}',
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
                          '${patientData['address']}, ${patientData['barangay']}, ${patientData['city']}, ${patientData['province']}, ${patientData['country']}',
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
                          '${patientData['email']}',
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
                          '${patientData['phone']}',
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
                  const SizedBox(height: 10.0),
                  for (var communityPost in communityPosts)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        title: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, left: 0.0),
                          child: Column(
                            // First Community Card
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF4454C3).withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color(0xFF4454C3)
                                        .withOpacity(0.15),
                                    width: .5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          '${communityPost['doctor_image']}', // Dynamic Variable
                                          height: 75,
                                          width: 75,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 25.0),
                                        Text(
                                          '${communityPost['doctor_title']}', // Dynamic Variable
                                          style: const TextStyle(
                                            color: Color(0xFF424E79),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 7.0),
                                        Text(
                                          '${communityPost['message']}', // Dynamic Variable
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
                        ),
                      ),
                    ),
                ],
              ),
            ),
            /* Community - End */
          ],
        ),
      ],
    );
  }
}

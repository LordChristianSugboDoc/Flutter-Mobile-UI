import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile_edit.dart';

class PatientProfileModal extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final Map<String, dynamic> patientCountry;
  final Map<String, dynamic> patientState;
  final Map<String, dynamic> patientCity;
  final Map<String, dynamic> patientBrgy;
  final List<Map<String, dynamic>> patientAllergy;

  PatientProfileModal(
    this.patientData,
    this.patientCountry,
    this.patientState,
    this.patientCity,
    this.patientBrgy,
    this.patientAllergy,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF4454C3).withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                    color: Color(0xFF424E79),
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PatientProfileEdit.routeName);
                  // Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.create_outlined,
                        size: 30,
                        color: Color(0xFF424E79),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF4454C3).withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: (patientData['img_url'] != null)
                    ? Image.network(
                        'http://10.0.2.2:8080/sugbodoc-multi-tenant/${patientData['img_url']}', // Dynamic Variable
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Use the default image if loading the image fails
                          return Image.asset(
                            'assets/images/JPG/default_profile.jpg',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/JPG/default_profile.jpg', // Dynamic Variable
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 18.0,
          ),
          Text(
            '${(patientData['name'] ?? '').substring(0, 8)}...',
            style: const TextStyle(
              color: Color(0xFF424E79),
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Patient',
            style: TextStyle(
              color: Color(0xFF424E79),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personal Details',
                    style: TextStyle(
                      color: Color(0xFF424E79),
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address:',
                        style: TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: (patientData['address'] != null)
                            ? Container(
                                child: Text(
                                  '${patientData['address']}, ${patientBrgy['name']}, ${patientCity['name']}, ${patientState['name']}, ${patientCountry['name']}',
                                  style: const TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Container(),
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
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 42,
                      ),
                      Text(
                        '${patientData['email']}',
                        style: const TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Text(
                        '${patientData['phone']}',
                        style: const TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Allergy:',
                        style: TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Flexible(
                        child: buildAllergyText(patientAllergy),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildAllergyText(List<Map<String, dynamic>> allergies) {
    if (allergies.isEmpty) {
      return const Text(
        'No allergies',
        style: TextStyle(
          color: Color(0xFF424E79),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    String allergyText;

    if (allergies.length == 1) {
      allergyText = '${allergies[0]['preferred_synonym']}';
    } else if (allergies.length == 2) {
      allergyText =
          '${allergies[0]['preferred_synonym']} and ${allergies[1]['preferred_synonym']}';
    } else {
      // Join all elements except the last one with commas,
      // and add 'and' before the last element.
      allergyText = allergies
          .sublist(0, allergies.length - 1)
          .map((allergy) => allergy['preferred_synonym'])
          .join(', ');
      allergyText += ', and ${allergies.last['preferred_synonym']}';
    }

    return Text(
      allergyText,
      style: const TextStyle(
        color: Color(0xFF424E79),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

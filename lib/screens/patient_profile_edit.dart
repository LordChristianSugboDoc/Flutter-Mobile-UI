import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/screens/patient_profile.dart';
import 'package:flutter_doctor_ui/widgets/CustomDropDown.dart';
import 'package:flutter_doctor_ui/widgets/CustomImageUpload.dart';
import 'package:flutter_doctor_ui/widgets/CustomInputField.dart';
import 'package:flutter_doctor_ui/widgets/DatePickerField.dart';
import 'package:flutter_doctor_ui/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientProfileEdit extends StatefulWidget {
  static String routeName = "/patientprofileedit";

  const PatientProfileEdit({super.key});

  @override
  State<PatientProfileEdit> createState() => _PatientProfileEditState();
}

class _PatientProfileEditState extends State<PatientProfileEdit> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController brgyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  late Future<void> _fetchPatientProfileEditFuture;
  Map<String, dynamic> patientData = {};
  File? _image;

  @override
  void initState() {
    checkStoragePermission();
    super.initState();
    _fetchPatientProfileEditFuture = _fetchPatientProfileEdit();
    _fetchPatientProfileEditFuture.then((_) {
      initializeControllers(patientData);
    });
  }

  String selectedCountry = 'Country';
  String selectedState = 'Province';
  String selectedCity = 'City';
  String selectedBrgy = 'Barangay';

  Future<void> checkStoragePermission() async {
    PermissionStatus storageStatus = await Permission.storage.status;
    if (storageStatus != PermissionStatus.granted) {
      await Permission.storage.request();
    }

    if (storageStatus == PermissionStatus.granted) {
      // Permission granted, perform actions.
    } else if (storageStatus == PermissionStatus.denied) {
      // Permission denied, handle accordingly.
    } else if (storageStatus == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied, consider opening app settings.
      openAppSettings();
    }
  }

  Future<void> _fetchPatientProfileEdit() async {
    String patientDetailsURL =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientDetails/${globalId}';

    try {
      final responsePatientDetails =
          await http.get(Uri.parse(patientDetailsURL));

      // Handle the response
      print(
          'Response Status Patient Data Code: ${responsePatientDetails.statusCode}');
      print('Response Patient Data Body: ${responsePatientDetails.body}');

      if (responsePatientDetails.statusCode == 200) {
        setState(() {
          patientData = json.decode(responsePatientDetails.body);

          // Ensure the correct type for patientPrescriptions
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updatePatientProfile() async {
    String URL =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/edit_patient_details/${globalId}';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(URL));
      request.fields.addAll({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'barangay': brgyController.text,
        'city': cityController.text,
        'state': stateController.text,
        'country': countryController.text,
        'birthdate': birthdateController.text,
      });

      if (_image != null) {
        // Attach the image file to the request
        request.files.add(
          await http.MultipartFile.fromPath('userfile', _image!.path),
        );
      }

      // Send the request
      final response = await request.send();

      // Handle the response
      final responseData = await http.Response.fromStream(response);
      print('Response Status Edit Patient Code: ${responseData.statusCode}');
      print('Response Edit Patient Body: ${responseData.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Color(0xFF4454C3)),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: Color(0xFF4454C3))),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat.yMMMMd().format(picked);
      birthdateController.text = formattedDate;
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String targetDirectoryPath =
          path.join(appDocumentsDirectory.path, 'uploads', 'profile');
      Directory targetDirectory = Directory(targetDirectoryPath);

      if (!(await targetDirectory.exists())) {
        Directory createdDirectory =
            await targetDirectory.create(recursive: true);
        if (createdDirectory == null) {
          print('Failed to create the directory: $targetDirectoryPath');
          return;
        }
      }

      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      String newImagePath = path.join(targetDirectoryPath, fileName);

      File newImage = File(newImagePath);

      await File(pickedFile.path).copy(newImage.path);

      String relativePath = path.join('uploads', 'profile', fileName);

      setState(() {
        _image = newImage;
        imageController.text = relativePath;
      });

      print('Image Path: ${_image?.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: _fetchPatientProfileEditFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4454C3)),
              ),
            );
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                iconTheme: const IconThemeData(
                  color: Color(0xFF4454C3),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PatientProfile.routeName);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.only(top: 10.0),
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 18.0,
                      bottom: 15.0,
                      right: 18.0,
                    ),
                    margin: const EdgeInsets.only(
                      top: 0.0,
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
                          "Edit Profile",
                          style: TextStyle(
                            color: Color(0xFF424E79),
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                            height:
                                8), // Add some space between text and divider
                        Divider(
                          color: const Color(0xFF4454C3).withOpacity(
                              0.15), // You can set the color of the divider
                          thickness:
                              1, // You can set the thickness of the divider
                        ),
                        const SizedBox(height: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomInputField(
                                  labelText: "First Name",
                                  hintText: "",
                                  inputWidth: width * .391,
                                  inputHeight: 60.0,
                                  controller: firstNameController,
                                  textInputType: TextInputType.text,
                                ),
                                const SizedBox(width: 12),
                                CustomInputField(
                                  labelText: "Last Name",
                                  hintText: "",
                                  inputWidth: width * .391,
                                  inputHeight: 60.0,
                                  controller: lastNameController,
                                  textInputType: TextInputType.text,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CustomInputField(
                              labelText: "Email Address",
                              hintText: "",
                              inputWidth: width,
                              inputHeight: 60.0,
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 15),
                            CustomInputField(
                              labelText: "Mobile Number",
                              hintText: "",
                              inputWidth: width,
                              inputHeight: 60.0,
                              controller: phoneController,
                              textInputType: TextInputType.phone,
                            ),
                            const SizedBox(height: 15),
                            CustomInputField(
                              labelText: "Address Line",
                              hintText: "",
                              inputWidth: width,
                              inputHeight: 60.0,
                              controller: addressController,
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomDropDown(
                                  labelText: 'Country',
                                  hintText: '',
                                  selectedValue: selectedCountry,
                                  inputWidth: width * .391,
                                  inputHeight: 60.0,
                                  items: const [
                                    'None',
                                    'Philippines',
                                    'Malaysia',
                                    'Thailand'
                                  ],
                                  onChanged: (String? value) {
                                    print(
                                        'onChanged executed. New value: $value');
                                    setState(() {
                                      selectedCountry = value ?? '';
                                    });
                                  },
                                ),
                                const SizedBox(width: 12),
                                CustomDropDown(
                                  labelText: 'State/Province',
                                  hintText: '',
                                  selectedValue: selectedState,
                                  inputWidth: width * .391,
                                  inputHeight: 60.0,
                                  items: const [
                                    'None',
                                    'Cebu',
                                    'Leyte',
                                    'Bohol'
                                  ],
                                  onChanged: (String? value) {
                                    if (patientData['province'] != null) {
                                      setState(() {
                                        selectedState =
                                            patientData['province'] ?? '';
                                      });
                                    } else {
                                      setState(() {
                                        selectedState = value ?? '';
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomDropDown(
                                  labelText: 'City',
                                  hintText: '',
                                  selectedValue: selectedCity,
                                  inputWidth: width * .391,
                                  inputHeight: 60.0,
                                  items: const [
                                    'None',
                                    'Cebu City',
                                    'Mandaue City',
                                    'Bogo City'
                                  ],
                                  onChanged: (String? value) {
                                    if (patientData['city'] != null) {
                                      setState(() {
                                        selectedCity =
                                            patientData['city'] ?? '';
                                      });
                                    } else {
                                      setState(() {
                                        selectedCity = value ?? '';
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(width: 12),
                                CustomDropDown(
                                  labelText: 'Barangay',
                                  hintText: '',
                                  selectedValue: selectedBrgy,
                                  inputWidth: width * .391,
                                  inputHeight: 60.0,
                                  items: const [
                                    'None',
                                    'Banilad',
                                    'Talamban',
                                    'Casuntingan'
                                  ],
                                  onChanged: (String? value) {
                                    if (patientData['barangay'] != null) {
                                      setState(() {
                                        selectedBrgy =
                                            patientData['barangay'] ?? '';
                                      });
                                    } else {
                                      setState(() {
                                        selectedBrgy = value ?? '';
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                DatePickerField(
                                  labelText: "Birth Date",
                                  hintText: "",
                                  inputWidth: width * .421,
                                  inputHeight: 60,
                                  controller: birthdateController,
                                  function: () => _handleDateSelection(context),
                                ),
                                const SizedBox(width: 12),
                                CustomImageDisplay(
                                  inputWidth: width * .361,
                                  inputHeight: 60,
                                  image: _image,
                                  onTap: _getImage,
                                  imagePathController: imageController,
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            PrimaryButton(
                              text: "Submit",
                              buttonColor: Color(0xFF4454C3),
                              onPress: () {
                                updateAddress();
                                _updatePatientProfile();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void updateAddress() {
    brgyController.text = '$selectedBrgy';
    cityController.text = '$selectedCity';
    stateController.text = '$selectedState';
    countryController.text = '$selectedCountry';
  }

  Future<void> _handleDateSelection(BuildContext context) async {
    await _selectDate(context);
  }

  void initializeControllers(Map<String, dynamic> patientData) {
    firstNameController.text = patientData['first_name'] ?? '';
    lastNameController.text = patientData['last_name'] ?? '';
    emailController.text = patientData['email'] ?? '';
    phoneController.text = patientData['phone'] ?? '';
    brgyController.text = patientData['barangay'] ?? '';
    cityController.text = patientData['city'] ?? '';
    stateController.text = patientData['province'] ?? '';
    countryController.text = patientData['country'] ?? '';
    addressController.text = patientData['address'] ?? '';
    birthdateController.text = patientData['birthdate'] ?? '';
    imageController.text = patientData['image'] ?? '';

    if (patientData != null && patientData['country'] != null) {
      selectedCountry = patientData['country'];
    }

    if (patientData != null && patientData['province'] != null) {
      selectedState = patientData['province'];
    }

    if (patientData != null && patientData['city'] != null) {
      selectedCity = patientData['city'];
    }

    if (patientData != null && patientData['barangay'] != null) {
      selectedBrgy = patientData['barangay'];
    }
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile.dart';
import 'package:flutter_doctor_ui/widgets/Profile/LargeEditPatientProfileBody.dart';
import 'package:flutter_doctor_ui/widgets/Profile/SmallEditPatientProfileBody.dart';
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
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/getPatientDetails/$globalId';

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
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/Patient/edit_patient_details/$globalId';

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
            colorScheme: const ColorScheme.light(primary: Color(0xFF4454C3)),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4454C3))),
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
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String targetDirectoryPath =
          path.join(appDocumentsDirectory.path, 'uploads', 'profile');
      Directory targetDirectory = Directory(targetDirectoryPath);

      if (!(await targetDirectory.exists())) {
        await targetDirectory.create(recursive: true);
        print('Failed to create the directory: $targetDirectoryPath');
        return;
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

      print('Image Path: $relativePath');
    }
  }

  double smallWidth = 600;
  double mediumWidth = 1000;
  @override
  Widget build(BuildContext context) {
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
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 26,
                  ),
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < smallWidth) {
                    return SmallEditPatientProfileBody(
                      patientData,
                      firstNameController,
                      lastNameController,
                      emailController,
                      phoneController,
                      addressController,
                      brgyController,
                      cityController,
                      stateController,
                      countryController,
                      birthdateController,
                      imageController,
                      _image,
                      updateAddress,
                      _updatePatientProfile,
                      () => _handleDateSelection(context),
                      _getImage,
                    );
                  } else if (constraints.maxWidth < mediumWidth) {
                    return _buildMediumScreenLayout();
                  } else {
                    return LargeEditPatientProfileBody(
                      patientData,
                      firstNameController,
                      lastNameController,
                      emailController,
                      phoneController,
                      addressController,
                      brgyController,
                      cityController,
                      stateController,
                      countryController,
                      birthdateController,
                      imageController,
                      _image,
                      updateAddress,
                      _updatePatientProfile,
                      () => _handleDateSelection(context),
                      _getImage,
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  void updateAddress() {
    brgyController.text = selectedBrgy;
    cityController.text = selectedCity;
    stateController.text = selectedState;
    countryController.text = selectedCountry;
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

    if (patientData['country'] != null) {
      selectedCountry = patientData['country'];
    }

    if (patientData['province'] != null) {
      selectedState = patientData['province'];
    }

    if (patientData['city'] != null) {
      selectedCity = patientData['city'];
    }

    if (patientData['barangay'] != null) {
      selectedBrgy = patientData['barangay'];
    }
  }

  Widget _buildMediumScreenLayout() {
    // Build UI for large screens
    return const Center(
      child: Text('Medium Edit Patient Profile Screen Layout'),
    );
  }

  Widget _buildLargeScreenLayout() {
    // Build UI for large screens
    return const Center(
      child: Text('Large Edit Patient Profile Screen Layout'),
    );
  }
}

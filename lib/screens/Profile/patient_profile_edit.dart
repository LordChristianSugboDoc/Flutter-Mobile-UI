import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Dashboard/dashboard.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/screens/Profile/patient_profile.dart';
import 'package:flutter_doctor_ui/widgets/Profile/LargeEditPatientProfileBody.dart';
import 'package:flutter_doctor_ui/widgets/Profile/SmallEditPatientProfileBody.dart';

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
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  late Future<void> _fetchPatientProfileEditFuture;
  Map<String, dynamic> responseData = {};
  Map<String, dynamic> patientData = {};
  Map<String, dynamic> patientCountry = {};
  Map<String, dynamic> patientState = {};
  Map<String, dynamic> patientCity = {};
  Map<String, dynamic> patientBrgy = {};

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
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/get_patient_details/$globalId';

    try {
      final responsePatientDetails =
          await http.get(Uri.parse(patientDetailsURL));

      // Handle the response
      print(
          'Response Status Patient Data Code: ${responsePatientDetails.statusCode}');
      print('Response Patient Data Body: ${responsePatientDetails.body}');

      if (responsePatientDetails.statusCode == 200) {
        setState(
          () {
            responseData = json.decode(responsePatientDetails.body);

            patientData = responseData['patientData'];
            patientCountry = responseData['patientCountry'];
            patientState = responseData['patientState'];
            patientCity = responseData['patientCity'];
            patientBrgy = responseData['patientBrgy'];
          },
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updatePatientProfile() async {
    String URL =
        'http://10.0.2.2:8080/sugbodoc-multi-tenant/index.php/api/auth/auth/edit_patient_details/$globalId';

    try {
      final request = http.MultipartRequest('POST', Uri.parse(URL));
      request.fields.addAll({
        'firstname': firstNameController.text,
        'lastname': lastNameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'barangay': brgyController.text,
        'city': cityController.text,
        'province': provinceController.text,
        'country': countryController.text,
        'birthdate': birthdateController.text,
        'img_url': imageController.text,
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
      print('New Image Path: $newImagePath');
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
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < smallWidth) {
                      // Small screen layout
                      return AppBar(
                        elevation: 0.0,
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        iconTheme: const IconThemeData(
                          color: Color(0xFF4454C3),
                        ),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PatientProfile.routeName);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 26,
                          ),
                        ),
                      );
                    } else if (constraints.maxWidth < mediumWidth) {
                      return const SizedBox();
                    } else {
                      return AppBar(
                        elevation: 0.0,
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        iconTheme: const IconThemeData(
                          color: Color(0xFF4454C3),
                        ),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Dashboard.routeName);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 26,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < smallWidth) {
                    return SmallEditPatientProfileBody(
                      patientData,
                      patientCountry,
                      patientState,
                      patientCity,
                      patientBrgy,
                      firstNameController,
                      lastNameController,
                      emailController,
                      phoneController,
                      addressController,
                      brgyController,
                      cityController,
                      provinceController,
                      countryController,
                      birthdateController,
                      imageController,
                      _image,
                      _updatePatientProfile,
                      () => _handleDateSelection(context),
                      _getImage,
                    );
                  } else if (constraints.maxWidth < mediumWidth) {
                    return _buildMediumScreenLayout();
                  } else {
                    return LargeEditPatientProfileBody(
                      patientData,
                      patientCountry,
                      patientState,
                      patientCity,
                      patientBrgy,
                      firstNameController,
                      lastNameController,
                      emailController,
                      phoneController,
                      addressController,
                      brgyController,
                      cityController,
                      provinceController,
                      countryController,
                      birthdateController,
                      imageController,
                      _image,
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

  Future<void> _handleDateSelection(BuildContext context) async {
    await _selectDate(context);
  }

  void initializeControllers(Map<String, dynamic> patientData) {
    firstNameController.text = patientData['firstname'] ?? '';
    lastNameController.text = patientData['lastname'] ?? '';
    emailController.text = patientData['email'] ?? '';
    phoneController.text = patientData['phone'] ?? '';
    brgyController.text = patientBrgy['name'] ?? '';
    cityController.text = patientCity['name'] ?? '';
    provinceController.text = patientState['name'] ?? '';
    countryController.text = patientCountry['name'] ?? '';
    addressController.text = patientData['address'] ?? '';
    birthdateController.text = patientData['birthdate'] ?? '';
    imageController.text = patientData['img_url'] ?? '';
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

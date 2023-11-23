import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/widgets/Registration/MediumScreenRegistrationBody.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_doctor_ui/widgets/Registration/SmallScreenRegistrationBody.dart';

class Registration extends StatefulWidget {
  static String routeName = "/registration";
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  bool obscurePassword = true;

  _RegisterPatient() async {
    String url =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/patient/registerPatient';

    Map<String, String> data = {
      'email': emailController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
      'birthdate': birthdateController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );

      // Handle the response as needed
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    } catch (error) {
      // Handle errors
      print(error);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SmallScreenRegistrationBody(
              emailController,
              phoneController,
              passwordController,
              birthdateController,
              handleObscurePassword,
              obscurePassword,
              _RegisterPatient,
              () => _handleDateSelection(context),
            );
          } else if (constraints.maxWidth < 1000) {
            return _buildMediumScreenLayout();
          } else {
            return MediumScreenRegistrationBody(
              emailController,
              phoneController,
              passwordController,
              birthdateController,
              handleObscurePassword,
              obscurePassword,
              _RegisterPatient,
              () => _handleDateSelection(context),
            );
          }
        },
      ),
    );
  }

  Widget _buildMediumScreenLayout() {
    // Build UI for large screens
    return Center(
      child: Text('Medium Registration Screen Layout'),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  Future<void> _handleDateSelection(BuildContext context) async {
    await _selectDate(context);
  }
}

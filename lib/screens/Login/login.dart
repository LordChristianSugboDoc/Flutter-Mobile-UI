import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/widgets/Login/LargeScreenLoginBody.dart';
import 'package:flutter_doctor_ui/widgets/Login/SmallScreenLoginBody.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_doctor_ui/screens/Dashboard/dashboard.dart';
import 'package:flutter_doctor_ui/screens/Registration/registration.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomTextField.dart';
import 'package:flutter_doctor_ui/widgets/General/PasswordField.dart';
import 'package:flutter_doctor_ui/widgets/General/PrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/General/SignInFacebookButton.dart';
import 'package:flutter_doctor_ui/widgets/General/SignInGoogleButton.dart';

class Login extends StatefulWidget {
  static String routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  int? parsedData;

  Future<int> _LoginPatient() async {
    String url =
        'http://10.0.2.2:8080/flutter-mobile-backend-ui/index.php/patient/loginPatient';

    Map<String, String> data = {
      'input': inputController.text,
      'password': passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );

      // Handle the response
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check the status code and parse data accordingly
      if (response.statusCode == 200) {
        // Successful response, parse integer or other data
        int parsedData = int.tryParse(response.body) ?? 0;
        return parsedData;
      } else {
        // Handle other status codes or error responses
        print('Error: ${response.statusCode}');
        // Return a default value or throw an exception if needed
        return 0;
      }
    } catch (error) {
      // Handle errors
      print('Error: $error');
      // Return a default value or throw an exception if needed
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SmallScreenLoginBody(
              inputController,
              passwordController,
              handleObscurePassword,
              obscurePassword,
              _LoginPatient,
            );
          } else if (constraints.maxWidth < 1000) {
            return _buildMediumScreenLayout();
          } else {
            return LargeScreenLoginBody(
              inputController,
              passwordController,
              handleObscurePassword,
              obscurePassword,
              _LoginPatient,
            );
          }
        },
      ),
    );
  }

  Widget _buildMediumScreenLayout() {
    // Build UI for large screens
    return Center(
      child: Text('Medium Login Screen Layout'),
    );
  }

  Widget _buildLargeScreenLayout() {
    // Build UI for large screens
    return Center(
      child: Text('Large Login Screen Layout'),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_doctor_ui/screens/dashboard.dart';
import 'package:flutter_doctor_ui/screens/registration.dart';
import 'package:flutter_doctor_ui/widgets/CustomTextField.dart';
import 'package:flutter_doctor_ui/widgets/PasswordField.dart';
import 'package:flutter_doctor_ui/widgets/PrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/SignInFacebookButton.dart';
import 'package:flutter_doctor_ui/widgets/SignInGoogleButton.dart';

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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: width * .87,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/PNG/sugbodoc_logo.png',
                      height: 110, // Set the desired height
                      width: 220, // Set the desired width
                    ),
                    const SizedBox(
                      height: 45.0,
                    ),
                    Container(
                      alignment: Alignment
                          .centerLeft, // Align the content to the left within the container
                      child: const Text(
                        "Login to your Account",
                        style: TextStyle(
                          color: Color(0xFF424E79),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    CustomTextField(
                      labelText: "Email or Mobile Number",
                      hintText: "Enter your Email or Mobile Number",
                      controller: inputController,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                        obscureText: obscurePassword,
                        onTap: handleObscurePassword,
                        labelText: "Password",
                        hintText: "Enter your Password",
                        controller: passwordController),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: Color(0xFF4454C3),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    PrimaryButton(
                      text: "Login",
                      buttonColor: Color(0xFF4454C3),
                      onPress: () async {
                        int parsedData = await _LoginPatient();
                        if (parsedData == 1) {
                          Navigator.pushNamed(context, Dashboard.routeName);
                        } else {
                          // Redirect to login page or handle the situation accordingly
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Login.routeName, (Route<dynamic> route) => false);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    const Text(
                      "Or sign in with",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GoogleButton(
                            borderWidth: 3.0,
                            buttonColor: Color.fromARGB(255, 255, 255, 255),
                            onPress: () {
                              // Your action when Google button is pressed
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: FacebookButton(
                            borderWidth: 3.0,
                            buttonColor: Color.fromARGB(255, 255, 255, 255),
                            onPress: () {
                              // Your action when Facebook button is pressed
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Registration.routeName);
                              },
                              child: const Text(
                                " Sign up",
                                style: TextStyle(
                                  color: Color(0xFF4454C3),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}

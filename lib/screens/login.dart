import 'package:flutter/material.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: width * .87,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/sugbodoc_logo.png',
                      height: 100, // Set the desired height
                      width: 200, // Set the desired width
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Please loin with your email or mobile number and password below",
                      style: TextStyle(
                        color: Color(0xFF424E79),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GoogleButton(
                      text: "Sign in with Google",
                      buttonColor: Color.fromARGB(255, 255, 255, 255),
                      onPress: () {
                        // Navigator.pushNamed(context, Dashboard.routeName);
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FacebookButton(
                      text: "Sign in with Facebook",
                      buttonColor: Color.fromARGB(255, 255, 255, 255),
                      onPress: () {
                        // Navigator.pushNamed(context, Dashboard.routeName);
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color.fromARGB(48, 66, 78,
                                  121), // Adjust the color as needed
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(48, 66, 78, 121),
                                    // Adjust the color of the circle
                                  ),
                                ),
                                const Text(
                                  "OR",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF424E79),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: const Color.fromARGB(48, 66, 78,
                                  121), // Adjust the color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(
                        labelText: "Email Address",
                        hintText: "Enter your Email Address",
                        controller: emailController,
                        textInputType: TextInputType.emailAddress),
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
                      height: 20.0,
                    ),
                    PrimaryButton(
                      text: "Login",
                      buttonColor: Color(0xFF4454C3),
                      onPress: () {
                        // Navigator.pushNamed(context, Dashboard.routeName);
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
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
                              onTap: () {},
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

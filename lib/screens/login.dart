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
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: width * .87,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/sugbodoc_logo.png',
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
                      labelText: "Email Address",
                      hintText: "Enter your Email Address",
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
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
                      onPress: () {
                        // Navigator.pushNamed(context, Dashboard.routeName);
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

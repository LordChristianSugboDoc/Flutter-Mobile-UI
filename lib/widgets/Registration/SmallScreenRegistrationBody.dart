import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomTextField.dart';
import 'package:flutter_doctor_ui/widgets/General/DatePickerField.dart';
import 'package:flutter_doctor_ui/widgets/General/PasswordField.dart';
import 'package:flutter_doctor_ui/widgets/General/PrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/General/SignInFacebookButton.dart';
import 'package:flutter_doctor_ui/widgets/General/SignInGoogleButton.dart';

class SmallScreenRegistrationBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController birthdateController;
  final VoidCallback handleObscurePassword;
  final bool obscurePassword;
  final VoidCallback _RegisterPatient;
  final VoidCallback _handleDateSelection;

  const SmallScreenRegistrationBody(
    this.emailController,
    this.phoneController,
    this.passwordController,
    this.birthdateController,
    this.handleObscurePassword,
    this.obscurePassword,
    this._RegisterPatient,
    this._handleDateSelection,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
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
                      "Create your Account",
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
                  CustomTextField(
                    labelText: "Phone Number",
                    hintText: "0987 654 321",
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                    obscureText: obscurePassword,
                    onTap: handleObscurePassword,
                    labelText: "Password",
                    hintText: "Enter your Password",
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DatePickerField(
                    labelText: "Birth Date",
                    hintText: "Select your Birthday",
                    inputWidth: width,
                    inputHeight: 60,
                    controller: birthdateController,
                    function: _handleDateSelection,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Sign up",
                    buttonColor: const Color(0xFF4454C3),
                    onPress: () {
                      _RegisterPatient();
                      Navigator.pushNamed(context, Login.routeName);
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
                          buttonColor: Colors.white,
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
                          buttonColor: Colors.white,
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
                            "Already have an account?",
                            style: TextStyle(
                              color: Color(0xFF424E79),
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Login.routeName);
                            },
                            child: const Text(
                              " Login",
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
    );
  }
}

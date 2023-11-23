import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomInputField.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPasswordField.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomSignInButton.dart';
import 'package:flutter_doctor_ui/widgets/General/DatePickerField.dart';

class MediumScreenRegistrationBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController birthdateController;
  final VoidCallback handleObscurePassword;
  final bool obscurePassword;
  final VoidCallback _RegisterPatient;
  final VoidCallback _handleDateSelection;

  MediumScreenRegistrationBody(
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
            child: Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: const EdgeInsets.only(
                    //   top: 30.0,
                    //   right: 10.0,
                    //   bottom: 10.0,
                    // ),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(
                      //     15.0), // Adjust the border radius as needed
                      child: Image.asset(
                        'assets/images/JPG/background_image_sugbodoc.jpg',
                        width: 554.40,
                        height: 792,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 80.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sign up for an account",
                              style: TextStyle(
                                color: Color(0xFF424E79),
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "Time to invest in your health",
                              style: TextStyle(
                                color: const Color(0xFF424E79).withOpacity(0.7),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomSignInButton(
                                    onPress: () {},
                                    buttonColor: const Color.fromARGB(
                                        255, 249, 251, 254),
                                    borderWidth: 220,
                                    borderHeight: 50,
                                    fontSize: 17,
                                    labelText: 'Sign in to Google',
                                    asset: 'assets/images/PNG/google_logo.png',
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  CustomSignInButton(
                                    onPress: () {},
                                    buttonColor: const Color.fromARGB(
                                        255, 249, 251, 254),
                                    borderWidth: 220,
                                    borderHeight: 50,
                                    fontSize: 17,
                                    labelText: 'Sign in to Facebook',
                                    asset:
                                        'assets/images/PNG/facebook_logo.png',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 155,
                                  child: Divider(
                                    height: .5,
                                    color: const Color(0xFF424E79).withOpacity(
                                        0.5), // Adjust the color of the line
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  "or Sign up here",
                                  style: TextStyle(
                                    color: Color(0xFF424E79).withOpacity(0.5),
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                  width: 155,
                                  child: Divider(
                                    height: .5,

                                    color: const Color(0xFF424E79).withOpacity(
                                        0.5), // Adjust the color of the line
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            CustomInputField(
                              labelText: 'Email Address',
                              hintText: 'Enter your Email Address',
                              inputWidth: 460,
                              inputHeight: 60,
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            CustomPasswordField(
                              obscureText: obscurePassword,
                              onTap: handleObscurePassword,
                              borderWidth: 460,
                              borderHeight: 60,
                              labelText: 'Password',
                              hintText: 'Enter your Password',
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomInputField(
                                  labelText: 'Mobile Number',
                                  hintText: '0987 654 3210',
                                  inputWidth: 220,
                                  inputHeight: 60,
                                  controller: phoneController,
                                  textInputType: TextInputType.phone,
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                DatePickerField(
                                  labelText: "Birth Date",
                                  hintText: "Select your Birthday",
                                  inputWidth: 220,
                                  inputHeight: 60,
                                  controller: birthdateController,
                                  function: _handleDateSelection,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "By creating an account, you are agreeing to our",
                                  style: TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 16.6,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    " Privacy Policy",
                                    style: TextStyle(
                                      color: Color(0xFF4454C3),
                                      fontSize: 16.6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Text(
                                  ".",
                                  style: TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 16.6,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            CustomPrimaryButton(
                              text: 'Create Account',
                              onPress: () {
                                _RegisterPatient();
                                Navigator.pushNamed(context, Login.routeName);
                              },
                              inputHeight: 60,
                              inputWidth: 460,
                              fontSize: 20,
                              fontColor: Colors.white,
                              buttonColor: const Color(0xFF4454C3),
                              buttonOutline: const Color(0xFF4454C3),
                              outlineWidth: 1,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 17,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Login.routeName);
                                  },
                                  child: const Text(
                                    " Login",
                                    style: TextStyle(
                                      color: Color(0xFF4454C3),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

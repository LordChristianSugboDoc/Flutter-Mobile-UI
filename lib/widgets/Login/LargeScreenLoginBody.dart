import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/main.dart';
import 'package:flutter_doctor_ui/screens/Dashboard/dashboard.dart';
import 'package:flutter_doctor_ui/screens/Login/login.dart';
import 'package:flutter_doctor_ui/screens/Registration/registration.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomInputField.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPasswordField.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomPrimaryButton.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomSignInButton.dart';

class LargeScreenLoginBody extends StatelessWidget {
  final TextEditingController inputController;
  final TextEditingController passwordController;
  final VoidCallback handleObscurePassword;
  final bool obscurePassword;
  final Future<int> Function() _LoginPatient;

  const LargeScreenLoginBody(
    this.inputController,
    this.passwordController,
    this.handleObscurePassword,
    this.obscurePassword,
    this._LoginPatient,
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
                        'assets/images/JPG/background_image_login.jpg',
                        width: 588,
                        height: 840,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Login to your account",
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
                              "Your health is our priority",
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
                                    borderWidth: 240,
                                    borderHeight: 50,
                                    fontSize: 17,
                                    labelText: 'Sign in to Google',
                                    asset: 'assets/images/PNG/google_logo.png',
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  CustomSignInButton(
                                    onPress: () {},
                                    buttonColor: const Color.fromARGB(
                                        255, 249, 251, 254),
                                    borderWidth: 240,
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
                                  width: 170,
                                  child: Divider(
                                    height: .5,
                                    color: const Color(0xFF424E79).withOpacity(
                                        0.3), // Adjust the color of the line
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  "or Login here",
                                  style: TextStyle(
                                    color: const Color(0xFF424E79)
                                        .withOpacity(0.5),
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                SizedBox(
                                  width: 170,
                                  child: Divider(
                                    height: .5,

                                    color: const Color(0xFF424E79).withOpacity(
                                        0.3), // Adjust the color of the line
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            CustomInputField(
                              labelText: 'Email or Mobile Number',
                              hintText: 'Enter your Email or Mobile Number',
                              inputWidth: 495,
                              inputHeight: 60,
                              controller: inputController,
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            CustomPasswordField(
                              obscureText: obscurePassword,
                              onTap: handleObscurePassword,
                              borderWidth: 495,
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
                                const Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 16.6,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    " Click here",
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
                              height: 20.0,
                            ),
                            CustomPrimaryButton(
                              text: 'Login',
                              onPress: () async {
                                int parsedData = await _LoginPatient();
                                if (parsedData != -1) {
                                  Navigator.pushNamed(
                                      context, Dashboard.routeName);
                                  globalId = parsedData;
                                  print(globalId);
                                } else {
                                  // Redirect to login page or handle the situation accordingly
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Login.routeName,
                                      (Route<dynamic> route) => false);
                                }
                              },
                              inputHeight: 60,
                              inputWidth: 495,
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
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Color(0xFF424E79),
                                    fontSize: 17,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Registration.routeName);
                                  },
                                  child: const Text(
                                    " Create Account",
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

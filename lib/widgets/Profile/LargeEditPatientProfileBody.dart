import 'package:flutter/material.dart';
import 'package:flutter_doctor_ui/ChangeNotifier/EditPatientProfile.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomDropDown.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomImageUpload.dart';
import 'package:flutter_doctor_ui/widgets/General/CustomInputField.dart';
import 'package:flutter_doctor_ui/widgets/General/DatePickerField.dart';
import 'package:flutter_doctor_ui/widgets/General/PrimaryButton.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class LargeEditPatientProfileBody extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController brgyController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController birthdateController;
  final TextEditingController imageController;
  final File? _image;
  final VoidCallback updateAddress;
  final VoidCallback _updatePatientProfile;
  final VoidCallback _handleDateSelection;
  final VoidCallback _getImage;

  LargeEditPatientProfileBody(
    this.patientData,
    this.firstNameController,
    this.lastNameController,
    this.emailController,
    this.phoneController,
    this.addressController,
    this.brgyController,
    this.cityController,
    this.stateController,
    this.countryController,
    this.birthdateController,
    this.imageController,
    this._image,
    this.updateAddress,
    this._updatePatientProfile,
    this._handleDateSelection,
    this._getImage,
  );

  @override
  Widget build(BuildContext context) {
    EditPatientProfile editPatientProfile =
        Provider.of<EditPatientProfile>(context);
    String selectedCountry = editPatientProfile.selectedCountry;
    String selectedState = editPatientProfile.selectedState;
    String selectedCity = editPatientProfile.selectedCity;
    String selectedBrgy = editPatientProfile.selectedBrgy;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 15.0,
            left: 18.0,
            bottom: 15.0,
            right: 18.0,
          ),
          margin: const EdgeInsets.only(
            top: 0.0,
            left: 20.0,
            bottom: 10.0,
            right: 20.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4454C3).withOpacity(0.25),
                blurRadius: 4, // Spread radius
                offset: const Offset(2, 2),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF4454C3).withOpacity(0.15),
              width: .5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(
                  color: Color(0xFF424E79),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                  height: 8), // Add some space between text and divider
              Divider(
                color: const Color(0xFF4454C3)
                    .withOpacity(0.15), // You can set the color of the divider
                thickness: 1, // You can set the thickness of the divider
              ),
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageDisplay(
                    inputWidth: 100,
                    inputHeight: 100,
                    image: _image,
                    onTap: _getImage,
                    imagePathController: imageController,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomInputField(
                        labelText: "First Name",
                        hintText: "",
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        controller: firstNameController,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(width: width * .014),
                      CustomInputField(
                        labelText: "Last Name",
                        hintText: "",
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        controller: lastNameController,
                        textInputType: TextInputType.text,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: "Email Address",
                    hintText: "",
                    inputWidth: width,
                    inputHeight: 60.0,
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      CustomInputField(
                        labelText: "Mobile Number",
                        hintText: "",
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(width: width * .014),
                      DatePickerField(
                        labelText: "Birth Date",
                        hintText: "",
                        inputWidth: width * .4625,
                        inputHeight: 60,
                        controller: birthdateController,
                        function: _handleDateSelection,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    labelText: "Address Line",
                    hintText: "",
                    inputWidth: width,
                    inputHeight: 60.0,
                    controller: addressController,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomDropDown(
                        labelText: 'Country',
                        hintText: '',
                        selectedValue: selectedCountry,
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        items: const [
                          'None',
                          'Philippines',
                          'Malaysia',
                          'Thailand'
                        ],
                        onChanged: (String? value) {
                          if (patientData['country'] != null) {
                            editPatientProfile.updateSelectedCountry(
                                patientData['country'] ?? '');
                          } else {
                            editPatientProfile
                                .updateSelectedCountry(value ?? '');
                          }
                        },
                      ),
                      SizedBox(width: width * .014),
                      CustomDropDown(
                        labelText: 'State/Province',
                        hintText: '',
                        selectedValue: selectedState,
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        items: const ['None', 'Cebu', 'Leyte', 'Bohol'],
                        onChanged: (String? value) {
                          if (patientData['province'] != null) {
                            editPatientProfile.updateSelectedState(
                                patientData['province'] ?? '');
                          } else {
                            editPatientProfile.updateSelectedState(value ?? '');
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomDropDown(
                        labelText: 'City',
                        hintText: '',
                        selectedValue: selectedCity,
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        items: const [
                          'None',
                          'Cebu City',
                          'Mandaue City',
                          'Bogo City'
                        ],
                        onChanged: (String? value) {
                          if (patientData['city'] != null) {
                            editPatientProfile
                                .updateSelectedCity(patientData['city'] ?? '');
                          } else {
                            editPatientProfile.updateSelectedCity(value ?? '');
                          }
                        },
                      ),
                      SizedBox(width: width * .014),
                      CustomDropDown(
                        labelText: 'Barangay',
                        hintText: '',
                        selectedValue: selectedBrgy,
                        inputWidth: width * .4625,
                        inputHeight: 60.0,
                        items: const [
                          'None',
                          'Banilad',
                          'Talamban',
                          'Casuntingan'
                        ],
                        onChanged: (String? value) {
                          if (patientData['barangay'] != null) {
                            editPatientProfile.updateSelectedBrgy(
                                patientData['barangay'] ?? '');
                          } else {
                            editPatientProfile.updateSelectedBrgy(value ?? '');
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    text: "Submit",
                    buttonColor: const Color(0xFF4454C3),
                    onPress: () {
                      updateAddress();
                      _updatePatientProfile();
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

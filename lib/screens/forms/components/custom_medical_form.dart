import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/components/custom_divider.dart';
import 'package:hostel_app_i2it/components/default_button.dart';
import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';

import '../../../size_config.dart';

// ███╗░░░███╗  ███████╗  ██████╗░  ██╗  ░█████╗░  ░█████╗░  ██╗░░░░░
// ████╗░████║  ██╔════╝  ██╔══██╗  ██║  ██╔══██╗  ██╔══██╗  ██║░░░░░
// ██╔████╔██║  █████╗░░  ██║░░██║  ██║  ██║░░╚═╝  ███████║  ██║░░░░░
// ██║╚██╔╝██║  ██╔══╝░░  ██║░░██║  ██║  ██║░░██╗  ██╔══██║  ██║░░░░░
// ██║░╚═╝░██║  ███████╗  ██████╔╝  ██║  ╚█████╔╝  ██║░░██║  ███████╗
// ╚═╝░░░░░╚═╝  ╚══════╝  ╚═════╝░  ╚═╝  ░╚════╝░  ╚═╝░░╚═╝  ╚══════╝

// ██╗███╗░░██╗███████╗░█████╗░██████╗░███╗░░░███╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
// ██║████╗░██║██╔════╝██╔══██╗██╔══██╗████╗░████║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
// ██║██╔██╗██║█████╗░░██║░░██║██████╔╝██╔████╔██║███████║░░░██║░░░██║██║░░██║██╔██╗██║
// ██║██║╚████║██╔══╝░░██║░░██║██╔══██╗██║╚██╔╝██║██╔══██║░░░██║░░░██║██║░░██║██║╚████║
// ██║██║░╚███║██║░░░░░╚█████╔╝██║░░██║██║░╚═╝░██║██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
// ╚═╝╚═╝░░╚══╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

class CustomMedicalForm extends StatefulWidget {
  const CustomMedicalForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomMedicalForm> createState() => _CustomMedicalFormState();
}

class _CustomMedicalFormState extends State<CustomMedicalForm> {
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  String gender = '';

  void nextFunction(context) {
    if (_bloodGroupController.text.trim() == '') {
      ErrorHandler().errorDialog(context, 'Please enter your Blood Group');
    } else if (_allergiesController.text.trim() == '') {
      ErrorHandler().errorDialog(context,
          'Please Enter your Allergies details. If not any then write none.');
    } else if (gender == '') {
      ErrorHandler().errorDialog(context, 'Please Enter your Gender');
    } else {
      AuthServices().setGender(gender);
      AuthServices().saveMedicalInfo(
          gender: gender,
          bloodGroup: _bloodGroupController.text.trim(),
          allergies: _allergiesController.text.trim());
    }
    Navigator.of(context).pop();
  }

  void selectGender() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = 'Male';
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Male'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = 'Female';
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Female'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gender
        _customGenderSelector(),
        const CustomDivider(),
        // Blood Group
        _customBloodGroup(),
        const CustomDivider(),
        //Allergies
        _customAllergies(),
        const CustomDivider(),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        // Next button
        DefaultButton(
          press: () {
            nextFunction(context);
          },
          text: 'Continue',
        )
      ],
    );
  }

  GestureDetector _customGenderSelector() {
    return GestureDetector(
      onTap: () {
        selectGender();
      },
      child: TextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: getProportionateScreenWidth(20),
        ),
        enabled: false,
        decoration: InputDecoration(
          label: Text(
            'Gender',
            style: TextStyle(
              color: Colors.grey,
              // fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          hintText: gender,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }

  TextField _customAllergies() {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      controller: _allergiesController,
      decoration: InputDecoration(
        label: Text(
          'Allergies',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        // hintText: cUser().displayName,
        // hintStyle: TextStyle(
        //   fontWeight: FontWeight.bold,
        //   color: Colors.black,
        //   fontSize: getProportionateScreenWidth(20),
        // ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextField _customBloodGroup() {
    return TextField(
      controller: _bloodGroupController,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      decoration: InputDecoration(
        label: Text(
          'Blood Group: ',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        // hintText: cUser().displayBloodGroup,
        // hintStyle: TextStyle(
        //   fontWeight: FontWeight.bold,
        //   color: Colors.black,
        //   fontSize: getProportionateScreenWidth(20),
        // ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}

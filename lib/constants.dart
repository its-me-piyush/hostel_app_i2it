import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/size_config.dart';


const haPrimaryColor = Colors.black;
const haPrimaryLightColor = Color(0xFFFFECDF);
const haPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const haSecondaryColor = Color(0xFF979797);
const haTextColor = Colors.black;

const haAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String haEmailNullError = "Please Enter your email";
const String haIrnNullError = "Please Enter your IRN";
const String haInvalidEmailError = "Please Enter Valid Email";
const String haPassNullError = "Please Enter your password";
const String haShortPassError =
    "Password is too short, must be more than 8 charecters";
const String haMatchPassError = "Passwords don't match";
const String haNamelNullError = "Please Enter your name";
const String haPhoneNumberNullError = "Please Enter your phone number";
const String haAddressNullError = "Please Enter your address";
const String haPhoneNumberInValidError = "Please Enter a valid phone number";
const String haNewUserMessage =
    'User with this credentials was not found!. Please check you credientials or signup :)';
const String haImageMissingError =
    'Image is missing, please update your profile image.';
const String haDOBMissingError =
    'Date of Birth not selected, please update your Date of Birth.';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: haTextColor),
  );
}

const String haRegistrationFailedMessage =
    'Uhh! Something went worng. Please Try again';

FirebaseAuth auth() {
  return FirebaseAuth.instance;
}

FirebaseFirestore firebaseFirestore() {
  return FirebaseFirestore.instance;
}

User cUser() {
  return FirebaseAuth.instance.currentUser!;
}

late String tempPhoneNumber;
late String veriId;
bool forgotSnackBar = false;
int formsCompleted = 1;

const String haResetLinkSendMessage =
    'Password Reset link successful sent, please check your Email!';
const String haNoRegisteredUserMessage =
    'User not registered!. Please Sign up :)';

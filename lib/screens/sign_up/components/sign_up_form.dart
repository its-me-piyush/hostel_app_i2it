import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/screens/complete_profile/complete_profile_screen.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? conformPassword;
  String? irn;
  String? year;
  bool isEmailError = false;
  bool isIrnError = false;
  bool isPassNullError = false;
  bool isYearNullError = false;
  bool isPassShortError = false;
  bool isConfirmPassSameError = false;
  bool isInvalidEmailError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ErrorHandler().loading(context, form(context))
        : form(context);
  }

  Form form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEmailFormField(),
          if (isEmailError)
            Text(
              '\u24E7 $haEmailNullError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          if (isInvalidEmailError)
            Text(
              '\u24E7 $haInvalidEmailError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildIrnFormField(),
          if (isIrnError)
            Text(
              '\u24E7 $haIrnNullError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildYearFormField(),
          if (isYearNullError)
            Text(
              '\u24E7 $haPassNullError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          if (isPassNullError)
            Text(
              '\u24E7 $haPassNullError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          if (isPassShortError)
            Text(
              '\u24E7 $haShortPassError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          if (isConfirmPassSameError)
            Text(
              '\u24E7 $haMatchPassError',
              style: TextStyle(
                color: Colors.red[800],
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              _formKey.currentState!.validate();
              if (!isEmailError &&
                  !isInvalidEmailError &&
                  !isIrnError &&
                  !isYearNullError &&
                  !isPassNullError &&
                  !isPassShortError &&
                  !isConfirmPassSameError) {
                _formKey.currentState!.save();
                setState(() {
                  isLoading = true;
                });
                AuthServices().signup(email!, password!, irn!).then((value) {
                  firebaseFirestore()
                      .collection('users')
                      .doc(value.user!.uid)
                      .set({
                    'email': value.user!.email,
                    'uid': value.user!.uid,
                    'IRN': irn,
                    'Year': year!.toUpperCase(),
                    'Gender': '',
                  }).onError((error, stackTrace) {
                    setState(() {
                      isLoading = false;
                    });
                    ErrorHandler()
                        .errorDialog(context, haNoRegisteredUserMessage);
                  }).whenComplete(() {
                    Navigator.pushNamedAndRemoveUntil(
                        context, CompleteProfileScreen.routeName, (_) => false,
                        arguments: {
                          'irn': irn,
                        });
                  });
                  firebaseFirestore().collection('userList').doc(irn).set({
                    'email': email,
                  }).catchError((e, _) {
                    setState(() {
                      isLoading = false;
                    });
                    ErrorHandler().errorDialog(context, e.message);
                  });
                }).catchError((e) {
                  setState(() {
                    isLoading = false;
                  });
                  ErrorHandler().errorDialog(context, e.message);
                });
                // Navigator.of(context)
                //     .pushNamed(CompleteProfileScreen.routeName);
                // if all are valid then go to success screen
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildConformPassFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isConfirmPassSameError ? Colors.red[800]! : Colors.black,
          width: 2,
        ),
      ),
      child: TextFormField(
        obscureText: true,
        onSaved: (newValue) => conformPassword = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isPassNullError = false;
            });
          }
          if (password == value) {
            setState(() {
              isConfirmPassSameError = false;
              isPassNullError = false;
            });
          }
          conformPassword = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isPassNullError = true;
            });
          }
          if ((password != value)) {
            // addError(error: haMatchPassError);
            setState(() {
              isConfirmPassSameError = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(239, 221, 141, 0.8),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Re-enter your password",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  Widget buildYearFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isYearNullError ? Colors.red : Colors.black,
          width: 2,
        ),
      ),
      child: TextFormField(
        onSaved: (newValue) => year = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isYearNullError = false;
            });
          }

          year = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isYearNullError = true;
            });
          }

          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(239, 221, 141, 0.8),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Enter your Year",
          suffixIcon: Icon(
            Icons.date_range_rounded,
          ),
        ),
      ),
    );
  }

  Widget buildPasswordFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isPassNullError || isPassShortError
              ? Colors.red[800]!
              : Colors.black,
          width: 2,
        ),
      ),
      child: TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isPassNullError = false;
            });
          }
          if (value.length >= 8) {
            setState(() {
              isPassNullError = false;
              isPassShortError = false;
            });
          }
          password = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isPassNullError = true;
            });
          }
          if (value.length < 8) {
            setState(() {
              isPassShortError = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(239, 221, 141, 0.8),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Enter your password",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isEmailError || isInvalidEmailError
              ? Colors.red[800]!
              : Colors.blue[900]!,
          width: 2,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isEmailError = false;
            });
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            setState(() {
              isInvalidEmailError = false;
            });
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isEmailError = true;
            });
          }
          if (!emailValidatorRegExp.hasMatch(value)) {
            setState(() {
              isInvalidEmailError = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          fillColor: Color.fromRGBO(124, 255, 196, 1),
          hintText: "Enter your email",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }

  Widget buildIrnFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
            color: isIrnError ? Colors.red[800]! : Colors.blue[900]!, width: 2),
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => irn = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isIrnError = false;
            });
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isIrnError = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(160, 212, 244, 0.8),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Enter your IRN (N190..)",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/irn_Icon.svg"),
        ),
      ),
    );
  }
}

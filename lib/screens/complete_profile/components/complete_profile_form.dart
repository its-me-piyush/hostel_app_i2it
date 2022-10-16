import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/helper/keyboard.dart';
import '../../../services/auth_services.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../otp/otp_screen.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  bool isFirstNameError = false;
  bool isLastNameError = false;
  bool isPhoneNumberNull = false;
  bool isPhoneNumberShort = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String irn = routeArgs['irn'];
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFirstNameFormField(),
          if (isFirstNameError)
            const Text(
              '\u24E7 $haNamelNullError',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          if (isLastNameError)
            const Text(
              '\u24E7 $haNamelNullError',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          if (isPhoneNumberNull)
            const Text(
              '\u24E7 $haPhoneNumberNullError',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          if (isPhoneNumberShort)
            const Text(
              '\u24E7 $haPhoneNumberInValidError',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(30)),
          StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore().collection('userList').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs
                  .where((element) => element.id != irn)
                  .toList();
              return DefaultButton(
                text: "Continue",
                press: () {
                  KeyboardUtil.hideKeyboard(context);
                  setState(() {
                    isLoading = true;
                  });
                  _formKey.currentState!.validate();
                  if (AuthServices()
                      .checkForDuplicatePhoneNumber(irn, phoneNumber!, data)) {
                    setState(() {
                      isLoading = false;
                    });
                    ErrorHandler().errorDialog(context,
                        'Phone number already exists. Please enter a new number.');
                  } else if (!isFirstNameError &&
                      !isLastNameError &&
                      !isPhoneNumberNull &&
                      !isPhoneNumberShort) {
                    _formKey.currentState!.save();
                    setState(() {
                      isLoading = true;
                    });

                    AuthServices()
                        .saveUserDetails(firstName!, lastName!, phoneNumber!)
                        .then((value) {
                      firebaseFirestore()
                          .collection('userList')
                          .doc(irn)
                          .update({
                        'phoneNumber': phoneNumber!,
                      }).catchError((e, _) {
                        setState(() {
                          isLoading = false;
                        });
                        ErrorHandler().errorDialog(context, e.message);
                      });
                      Navigator.pushNamedAndRemoveUntil(
                          context, OtpScreen.routeName, (_) => false);
                    }).catchError((e) {
                      setState(() {
                        isLoading = false;
                      });
                      ErrorHandler().errorDialog(context, e.message);
                    });
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildPhoneNumberFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isPhoneNumberNull || isPhoneNumberShort
              ? Colors.red[800]!
              : Colors.black,
          width: 2,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phoneNumber = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isPhoneNumberNull = false;
            });
          }
          if (value.length == 10) {
            setState(() {
              isPhoneNumberShort = false;
            });
          }
          phoneNumber = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isPhoneNumberNull = true;
            });
          }
          if (value.length != 10) {
            setState(() {
              isPhoneNumberShort = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(255, 204, 132, 1),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Enter your phone number",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        ),
      ),
    );
  }

  Widget buildLastNameFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isLastNameError ? Colors.red[800]! : Colors.blue[900]!,
          width: 2,
        ),
      ),
      child: TextFormField(
        onSaved: (newValue) => lastName = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isLastNameError = false;
            });
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isLastNameError = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(144, 70, 207, 0.7),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Enter your last name",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      ),
    );
  }

  Widget buildFirstNameFormField() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isFirstNameError ? Colors.red[800]! : Colors.blue[900]!,
          width: 2,
        ),
      ),
      child: TextFormField(
        onSaved: (newValue) => firstName = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isFirstNameError = false;
            });
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isFirstNameError = true;
            });
          }
          return null;
        },
        decoration: const InputDecoration(
          filled: false,
          fillColor: Color.fromRGBO(144, 70, 207, 0.7),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Enter your first name",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      ),
    );
  }
}

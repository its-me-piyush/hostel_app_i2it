import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/screens/hostelDetails/hostel_details_screen.dart';

import '../../../../constants.dart';
import '../../../helper/keyboard.dart';
import '/services/auth_services.dart';
import '../../../../size_config.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? irn;
  String? password;
  bool? remember = false;
  bool isIrnError = false;
  bool isPasswordError = false;
  bool isPasswordNullError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ErrorHandler().loading(
            context,
            _form(context),
          )
        : _form(context);
  }

  Form _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          irnLoginWidget(),
          if (isIrnError)
            const Text(
              "\u24E7 $haIrnNullError",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(20)),
          passLoginWidget(),
          if (isPasswordError)
            const Text(
              "\u24E7 $haPassNullError",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          if (isPasswordNullError)
            const Text(
              '\u24E7 $haShortPassError',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(height: getProportionateScreenHeight(60)),

          // the login button
          DefaultButton(
            text: "Login",
            press: () {
              _formKey.currentState!.validate();
              if (!isIrnError && !isPasswordError && !isPasswordNullError) {
                _formKey.currentState!.save();
                setState(() {
                  isLoading = true;
                });
                // if all are valid then go to success screen
                AuthServices().signIn(context, irn!, password!).then((value) {
                  KeyboardUtil.hideKeyboard(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, HostelDetailsScreen.routeName, (route) => false);
                }).catchError((e) {
                  setState(() {
                    isLoading = false;
                  });
                  // ScaffoldMessenger.of(context).clearSnackBars();
                  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //   content: Text(
                  //     haNewUserMessage,
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   backgroundColor: Colors.red,
                  // ));
                  ErrorHandler().errorDialog(context, haNewUserMessage);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget passLoginWidget() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isPasswordError
              ? Colors.red[800]!
              : isPasswordNullError
                  ? Colors.red[800]!
                  : Colors.black,
          width: 2,
        ),
      ),
      child: TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              isPasswordError = true;
            });
          }
          if (value.isNotEmpty && value.length < 8) {
            setState(() {
              isPasswordError = false;
              isPasswordNullError = true;
            });
            password = value;
          } else if (value.isNotEmpty) {
            setState(() {
              isPasswordError = false;
              isPasswordNullError = false;
            });
          }

          return;
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          fillColor: Color.fromRGBO(70, 70, 70, 0.2),
          hintText: "Enter your password",
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  Widget irnLoginWidget() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: isIrnError ? Colors.red[800]! : Colors.blue[900]!,
          width: 2,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => irn = newValue,
        validator: (value) {
          if (value!.isNotEmpty) {
            setState(() {
              isIrnError = false;
            });
          }
          if (value.isEmpty) {
            setState(() {
              isIrnError = true;
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
          fillColor: Color.fromRGBO(111, 255, 233, 0.8),
          floatingLabelStyle: TextStyle(color: haPrimaryColor),
          hintText: "Enter your IRN (N190..)",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/irn_Icon.svg"),
        ),
      ),
    );
  }
}

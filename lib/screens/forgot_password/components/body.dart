import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/components/form_error.dart';
import 'package:hostel_app_i2it/components/no_account_text.dart';
import 'package:hostel_app_i2it/helper/keyboard.dart';
import 'package:hostel_app_i2it/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '/components/default_button.dart';
import '/components/custom_surfix_icon.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              const ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;

  @override
  void initState() {
    super.initState();
    forgotSnackBar = false;
  }

  void forgotPassword(String email) async {
    try {
      await auth().sendPasswordResetEmail(email: email).whenComplete(() {
        setState(() {
          forgotSnackBar = true;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(haResetLinkSendMessage)));
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(haNoRegisteredUserMessage),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(haEmailNullError)) {
                setState(() {
                  errors.remove(haEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(haInvalidEmailError)) {
                setState(() {
                  errors.remove(haInvalidEmailError);
                });
              }
              email = value;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(haEmailNullError)) {
                setState(() {
                  errors.add(haEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(haInvalidEmailError)) {
                setState(() {
                  errors.add(haInvalidEmailError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: forgotSnackBar ? 'Go to SignIn' : "Continue",
            press: () {
              KeyboardUtil.hideKeyboard(context);
              if (!forgotSnackBar) {
                KeyboardUtil.hideKeyboard(context);
                if (_formKey.currentState!.validate()) {
                  // Do what you want to do
                  forgotPassword(email!);
                }
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInScreen.routeName, (route) => false);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          const NoAccountText(),
        ],
      ),
    );
  }
}

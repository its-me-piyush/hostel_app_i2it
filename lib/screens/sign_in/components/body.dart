import 'package:flutter/material.dart';

import '/size_config.dart';
import './signin_form.dart';
import '/screens/sign_up/sign_up_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenHeight(70),
                width: getProportionateScreenWidth(35),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(80),
              ),
              Text(
                'Heyy,',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(36),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Login Now.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(32),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('If you are new /'),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignUpScreen.routeName),
                    child: const Text(
                      'Create New',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              const SignForm(),
            ],
          ),
        ),
      ),
    );
  }
}

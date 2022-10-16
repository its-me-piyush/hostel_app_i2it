import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/screens/forms/components/custom_personal_form.dart';
import 'package:hostel_app_i2it/size_config.dart';

import 'user_image.dart';

class PersonalForm extends StatelessWidget {
  const PersonalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: const UserImage(),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(15)),
              child: const CustomPersonalForm(),
            ),
          ],
        ),
      ),
    );
  }
}

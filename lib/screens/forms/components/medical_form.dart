import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/size_config.dart';

import 'custom_medical_form.dart';

class MedicalForm extends StatelessWidget {
  const MedicalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical Info')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(15)),
              child: const CustomMedicalForm(),
            ),
          ],
        ),
      ),
    );
  }
}

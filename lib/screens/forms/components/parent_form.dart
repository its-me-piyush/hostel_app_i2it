import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/size_config.dart';

import 'custom_parent_form.dart';

class ParentForm extends StatelessWidget {
  const ParentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent/Guardian Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(15)),
              child: const CustomParentForm(),
            ),
          ],
        ),
      ),
    );
  }
}

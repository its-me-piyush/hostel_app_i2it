import 'package:flutter/material.dart';

import 'components/personal_form.dart';

class Forms extends StatelessWidget {
  const Forms({Key? key}) : super(key: key);
  static const String routeName = '/forms';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: _customFormsAppBar(),
      body: const PersonalForm(),
    );
  }

  AppBar _customFormsAppBar() {
    return AppBar(
      title: const Text(
        ' Personal Info',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      // centerTitle: true,
    );
  }
}

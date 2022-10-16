import 'package:flutter/material.dart';

import '/size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-in';

  // basic landing page for sign in.
  @override
  Widget build(BuildContext context) {
    // to initialize size config.
    SizeConfig().init(context);

    return const Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}

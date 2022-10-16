import 'package:flutter/material.dart';

import '../size_config.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      height: getProportionateScreenHeight(10),
      endIndent: getProportionateScreenHeight(5),
      indent: getProportionateScreenHeight(5),
      thickness: getProportionateScreenHeight(2),
    );
  }
}

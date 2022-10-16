import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';

import '../../../size_config.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Complete your',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
          ),
        ),
        Row(
          children: [
            Text(
              'Personal Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(28),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                AuthServices().signOut(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(20),
                  ),
                  color: Colors.grey[350],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                ),
                child: Icon(
                  Icons.arrow_right_alt_rounded,
                  size: getProportionateScreenWidth(44),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

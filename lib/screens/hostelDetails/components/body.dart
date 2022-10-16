import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hostel_app_i2it/provider/home_menu_provider.dart';
import 'package:hostel_app_i2it/size_config.dart';

import 'menu_items.dart';
import 'top_banner.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(15),
          right: getProportionateScreenWidth(15)),
      child: Column(
        children: [
          const TopBanner(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          const MenuItems(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Expanded(
            child: Consumer<HomeMenuProvider>(
              builder: (context, value, child) {
                var currentWidget = value.getCurrentMenuWidget;
                return currentWidget;
              },
            ),
          ),
        ],
      ),
    );
  }
}

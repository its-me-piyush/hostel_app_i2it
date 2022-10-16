import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/enums.dart';
import 'package:hostel_app_i2it/provider/home_menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuSelected = Provider.of<HomeMenuProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _menuItem(context,
            title: 'Upcomming',
            homeOptions: HomeOptions.upcomming,
            isActive: menuSelected.getCurrentMenuItemSelected ==
                HomeOptions.upcomming),
        _menuItem(context,
            title: 'Processing',
            homeOptions: HomeOptions.processing,
            isActive: menuSelected.getCurrentMenuItemSelected ==
                HomeOptions.processing),
        _menuItem(context,
            title: 'Done',
            
            homeOptions: HomeOptions.done,
            isActive:
                menuSelected.getCurrentMenuItemSelected == HomeOptions.done),
        _menuItem(context,
            title: 'Help/FAQs',
            homeOptions: HomeOptions.help,
            
            isActive:
                menuSelected.getCurrentMenuItemSelected == HomeOptions.help),
      ],
    );
  }

  Widget _menuItem(BuildContext context,
      {required String title, required bool isActive,required HomeOptions homeOptions}) {
    return GestureDetector(
      onTap: () {
        Provider.of<HomeMenuProvider>(context, listen: false)
            .changeSelected(homeOptions);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey[600],
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          if (isActive)
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20), vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
              ),
            )
        ],
      ),
    );
  }
}

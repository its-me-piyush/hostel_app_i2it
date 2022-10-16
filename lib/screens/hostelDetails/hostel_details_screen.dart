import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class HostelDetailsScreen extends StatelessWidget {
  const HostelDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/hostel-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hey, ${cUser().displayName!.split(' ')[0]}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: getProportionateScreenWidth(10),
            ),
            child: CircleAvatar(
              backgroundImage: cUser().photoURL == null
                  ? null
                  : NetworkImage(cUser().photoURL!),
            ),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}

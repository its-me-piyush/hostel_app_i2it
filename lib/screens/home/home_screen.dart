import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_app_i2it/constants.dart';
import 'package:hostel_app_i2it/provider/current_user_provider.dart';
import 'package:hostel_app_i2it/screens/addRooms/add_rooms_screen.dart';
import 'package:hostel_app_i2it/screens/warden_display/warden_display_screen.dart';
import 'package:hostel_app_i2it/size_config.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../smart_room/smart_room.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: getProportionateScreenHeight(20),
            right: getProportionateScreenWidth(20),
            child: FloatingActionButton(
              heroTag: 'SingleRoom',
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SmartRoom(),
                  ),
                );
              },
              child: Icon(
                Icons.smart_button_rounded,
                size: getProportionateScreenWidth(30),
              ),
            ),
          ),
          Positioned(
            bottom: getProportionateScreenHeight(20),
            left: getProportionateScreenWidth(20),
            child: FloatingActionButton(
              heroTag: 'Warden',
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WardenDisplayScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.smart_display_rounded,
                size: getProportionateScreenWidth(30),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            // margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  getProportionateScreenWidth(20),
                ),
              ),
            ),
            elevation: 2,
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        getProportionateScreenWidth(20),
                      ),
                      bottomLeft: Radius.circular(
                        getProportionateScreenWidth(20),
                      ),
                    ),
                  ),
                  width: getProportionateScreenWidth(100),
                  child: Image.network(cUser().photoURL!),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: firebaseFirestore().collection('users').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = snapshot.data!.docs;
                    var currentUser = data
                        .firstWhere((element) => element['uid'] == cUser().uid);
                    Provider.of<CurrentUserProvider>(context, listen: false)
                        .setUserDetails(currentUser.data());
                    return Container(
                      margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${cUser().displayName!}',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'IRN: ${currentUser['IRN']}',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(20),
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Room No.: ${currentUser['bookedRoomNo']}',
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(20),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(
              getProportionateScreenWidth(10),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'Emergency Contacts: ',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                SizedBox(
                  height: getProportionateScreenHeight(60),
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CircleAvatar(
                        maxRadius: getProportionateScreenHeight(40),
                      );
                    },
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                // Dismissible(
                //   key: const ValueKey('cleaner'),
                //   direction: DismissDirection.startToEnd,
                //   background: Container(
                //     color: Colors.red,
                //   ),
                //   onDismissed: (direction) {},
                //   confirmDismiss: (direction) async {
                //     await showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text("Confirm"),
                //           content: const Text(
                //               "Are you sure you want to call the cleaner?"),
                //           actions: <Widget>[
                //             TextButton(
                //                 onPressed: () {
                //                   Navigator.of(context).pop(false);
                //                   launch('tel:+918308298646');
                //                 },
                //                 child: const Text("Yes")),
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop(false);
                //                 print('Not called');
                //               },
                //               child: const Text("No"),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   child: Card(
                //     elevation: 2,
                //     color: Colors.deepPurpleAccent.withOpacity(0.5),
                //     child: ListTile(
                //       leading: Icon(
                //         FontAwesomeIcons.chevronCircleRight,
                //         color: Colors.black,
                //         size: getProportionateScreenWidth(30),
                //       ),
                //       title: Text(
                //         'Swipe to call cleaner',
                //         style: TextStyle(
                //           fontSize: getProportionateScreenWidth(20),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Center(
                    child: TableCalendar(
                  firstDay: DateTime(2016),
                  lastDay: DateTime(2030),
                  focusedDay: DateTime.now(),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

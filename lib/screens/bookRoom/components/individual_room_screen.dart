import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hostel_app_i2it/constants.dart';
import 'package:hostel_app_i2it/provider/current_user_provider.dart';
import 'package:hostel_app_i2it/screens/hostelDetails/hostel_details_screen.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';
import 'package:hostel_app_i2it/size_config.dart';
import 'package:provider/provider.dart';

class IndividualRoomScreen extends StatelessWidget {
  const IndividualRoomScreen({Key? key, required this.roomData})
      : super(key: key);
  final QueryDocumentSnapshot roomData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          roomData['title'],
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            StreamBuilder<QuerySnapshot>(
              stream: firebaseFirestore()
                  .collection('rooms')
                  .doc(roomData.id)
                  .collection('booked')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List data = snapshot.data!.docs;
                if (data.isEmpty) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(20),
                      ),
                    ),
                    shadowColor: Colors.blue[900],
                    child: ListTile(
                      leading: Icon(
                        Icons.hourglass_empty_rounded,
                        color: Colors.red,
                        size: getProportionateScreenWidth(40),
                      ),
                      title: const Text('No confirmed occupants'),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(20),
                      ),
                    ),
                    shadowColor: Colors.blue[900],
                    child: ListTile(
                      leading: Icon(
                        Icons.bed_rounded,
                        color: Colors.blue[900],
                        size: getProportionateScreenWidth(40),
                      ),
                      title: Text(data[index]['occupant']),
                      subtitle: RichText(
                        text: TextSpan(
                          text: data[index]['branch'],
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${data[index]['year']} year',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firebaseFirestore()
                  .collection('rooms')
                  .doc(roomData.id)
                  .collection('recommended')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                List data = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(20),
                      ),
                    ),
                    shadowColor: Colors.amber,
                    child: ListTile(
                      leading: Icon(
                        Icons.bed_rounded,
                        color: Colors.amber,
                        size: getProportionateScreenWidth(40),
                      ),
                      title: Text(data[index]['occupant']),
                      subtitle: RichText(
                        text: TextSpan(
                          text: data[index]['branch'],
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${data[index]['year']} year',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: roomData['occupancy'] == roomData['booked']
                    ? Colors.grey
                    : Colors.black,
              ),
              onPressed: () {
                if (roomData['occupancy'] != roomData['booked']) {
                  AuthServices()
                      .saveBookedRoomDetails(
                          roomData.id, roomData['booked'], roomData['title'])
                      .then((value) {
                    Provider.of<CurrentUserProvider>(context, listen: false)
                        .setUserDetails({
                      'name': cUser().displayName,
                      'roomNo': roomData['title'],
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HostelDetailsScreen(),
                        ),
                        (route) => false);
                  });
                }
              },
              child: const Text(
                'Select this room',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

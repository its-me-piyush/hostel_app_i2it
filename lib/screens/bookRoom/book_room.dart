import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/constants.dart';
import 'package:hostel_app_i2it/screens/bookRoom/components/individual_room_screen.dart';
import 'package:hostel_app_i2it/size_config.dart';

class BookRoomScreen extends StatelessWidget {
  const BookRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Room',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore()
            .collection('rooms')
            .orderBy('title', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List data = snapshot.data!.docs;
          return Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateScreenWidth(20),
                mainAxisSpacing: getProportionateScreenHeight(20),
              ),
              itemCount: data.length,
              itemBuilder: (context, roomIndex) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          IndividualRoomScreen(roomData: data[roomIndex]),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(20),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(20),
                    ),
                    border: Border.all(
                      color: Colors.blue[900]!,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data[roomIndex]['title'],
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (data[roomIndex]['booked'] > 0)
                            SizedBox(
                              height: 20,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data[roomIndex]['booked'],
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Container(
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[900]!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (data[roomIndex]['recommended'] > 0)
                            SizedBox(
                              height: 20,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data[roomIndex]['recommended'],
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Container(
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          SizedBox(
                            height: 20,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data[roomIndex]['occupancy'] -
                                  data[roomIndex]['booked'] -
                                  data[roomIndex]['recommended'],
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Container(
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

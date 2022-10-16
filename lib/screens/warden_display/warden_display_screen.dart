import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/size_config.dart';

import '../../constants.dart';
import '../../services/auth_services.dart';

class WardenDisplayScreen extends StatefulWidget {
  const WardenDisplayScreen({Key? key}) : super(key: key);

  @override
  State<WardenDisplayScreen> createState() => _WardenDisplayScreenState();
}

class _WardenDisplayScreenState extends State<WardenDisplayScreen> {
  String selectedRoom = 'N007';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Warden Display',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // shape: BoxShape.rectangle,
                border: Border.all(
                  width: 2,
                ),
              ),
              child: TextField(
                onSubmitted: (value) => setState(() {
                  selectedRoom = value;
                }),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  filled: false,
                  fillColor: Color.fromRGBO(111, 255, 233, 0.8),
                  floatingLabelStyle: TextStyle(color: haPrimaryColor),
                  hintText: "Enter Room No.",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Expanded(
                child: StreamBuilder<DatabaseEvent>(
              stream: FirebaseDatabase.instance.ref(selectedRoom).onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.snapshot.value == null) {
                  return const Center(
                    child: Text('Room Data Not Available'),
                  );
                }
                var roomData = Map<String, bool>.from(
                    snapshot.data!.snapshot.value as Map);
                // return Container();

                List<String> roomDataKeys = List<String>.from(roomData.keys);
                return Column(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          getProportionateScreenWidth(10),
                        ),
                        child: SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(15)),
                                child: Row(
                                  children: [
                                    Text(
                                      selectedRoom,
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(20),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: getProportionateScreenWidth(8),
                                endIndent: getProportionateScreenWidth(8),
                                height: getProportionateScreenHeight(5),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(15)),
                                child: Row(
                                  children: [
                                    Text(
                                      'Devices Connect\n${roomData.length} online',
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(15),
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              getProportionateScreenWidth(10),
                                            ),
                                          ),
                                          primary: const Color(0xFF70B6B0)),
                                      onPressed: () {},
                                      child: Center(
                                        child: Text(
                                          'Check',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: getProportionateScreenHeight(10),
                            crossAxisSpacing: getProportionateScreenWidth(10)),
                        itemCount: roomData.length,
                        itemBuilder: (context, index) {
                          bool ledValue = roomData[roomDataKeys[index]]!;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ledValue
                                    ? const Color(0xFF70B6B0)
                                    : Colors.black,
                                width: 2,
                              ),
                              color: ledValue
                                  ? const Color(0xFF70B6B0)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      margin: EdgeInsets.all(
                                          getProportionateScreenWidth(20)),
                                      duration:
                                          const Duration(milliseconds: 500),
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(2)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(5),
                                        ),
                                        color: ledValue
                                            ? Colors.white
                                            : const Color(0xFF70B6B0),
                                      ),
                                      child: Icon(
                                        Icons.lightbulb_outline_rounded,
                                        size: getProportionateScreenWidth(30),
                                      ),
                                    ),
                                    const Spacer(),
                                    Switch(
                                      activeTrackColor: Colors.white,
                                      thumbColor: MaterialStateProperty.all(
                                        const Color(0xFF70B6B0),
                                      ),
                                      value: ledValue,
                                      onChanged: (value) {
                                        // print(
                                        //     '$selectedRoom = ${roomDataKeys[index]} - ${roomData[roomDataKeys[index]]}');
                                        AuthServices().toggleLed(
                                            roomDataKeys[index],
                                            !ledValue,
                                            selectedRoom);
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  roomDataKeys[index],
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(20),
                                    fontWeight: FontWeight.bold,
                                    color:
                                        ledValue ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text(
                                  'Status: ${ledValue ? 'ON' : 'OFF'}',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15),
                                    color:
                                        ledValue ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

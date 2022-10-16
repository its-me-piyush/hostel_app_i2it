import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/constants.dart';
import 'package:hostel_app_i2it/size_config.dart';

class AddRoomsScreen extends StatefulWidget {
  const AddRoomsScreen({Key? key}) : super(key: key);

  @override
  State<AddRoomsScreen> createState() => _AddRoomsScreenState();
}

class _AddRoomsScreenState extends State<AddRoomsScreen> {
  String floor = '99';
  String maxRcmnd = '99';
  String occupancy = '99';
  String roomType = '99';
  String roomTitle = '99';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Room',
          style: TextStyle(fontSize: getProportionateScreenWidth(20)),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(
            getProportionateScreenWidth(20),
          ),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (value) => floor = value!,
                  decoration: InputDecoration(
                    hintText: 'floor',
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (value) => maxRcmnd = value!,
                  decoration: InputDecoration(
                    hintText: 'maxRcmnd',
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (value) => occupancy = value!,
                  decoration: InputDecoration(
                    hintText: 'occupancy',
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (value) => roomType = value!,
                  decoration: InputDecoration(
                    hintText: 'room type',
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  onSaved: (value) => roomTitle = value!,
                  decoration: InputDecoration(
                    hintText: 'title',
                    hintStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await firebaseFirestore().collection('rooms').add({
                          'booked': 0,
                          'floor': int.parse(floor),
                          'maxRcmnd': int.parse(maxRcmnd),
                          'occupancy': int.parse(occupancy),
                          'recommended': 0,
                          'roomType': roomType,
                          'title': roomTitle,
                        }).then((value) {
                          firebaseFirestore()
                              .collection('rooms')
                              .doc(value.id)
                              .update({
                            'id': value.id,
                          });
                          print('Value id: ${value.id}');
                        });
                      }
                    },
                    child: Text(
                      'Add Room',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}

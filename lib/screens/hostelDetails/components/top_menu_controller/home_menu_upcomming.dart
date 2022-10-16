import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_app_i2it/provider/book_room_provider.dart';
import 'package:hostel_app_i2it/provider/current_user_provider.dart';
import 'package:hostel_app_i2it/provider/payment_details_provider.dart';
import 'package:hostel_app_i2it/screens/bookRoom/book_room.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/forms_provider.dart';
import '../../../../size_config.dart';
import '../../../home/home_screen.dart';

class HomeMenuUpcomming extends StatelessWidget {
  const HomeMenuUpcomming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore()
              .collection('users')
              .doc(cUser().uid)
              .collection('Forms')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data!.docs;
            Provider.of<FormsProvider>(context).setFromListIndex(data.length);
            if (Provider.of<FormsProvider>(context).getFormPercentage == 100) {
              return _customCompletedCard(
                  bgColor: const Color(0xFF12D3FB), title: 'Forms');
            }
            return _customCards(
              bgColor: const Color(0xFF12D3FB),
              percentage: Provider.of<FormsProvider>(context).getFormPercentage,
              title: 'Forms.',
              subTitle:
                  Provider.of<FormsProvider>(context).getFormsCurrentFormName,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Provider.of<FormsProvider>(context).getFormsCurrentScreen,
                ));
              },
            );
          },
        ),
        StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore()
              .collection('users')
              .doc(cUser().uid)
              .collection('allottedRoom')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data!.docs;
            Provider.of<BookRoomProvider>(context)
                .setBookedRoomPercentage(data.length);
            if (Provider.of<BookRoomProvider>(context).getBookFormsPercentage ==
                100) {
              return _customCompletedCard(
                  bgColor: const Color(0xFFF4DE5C), title: 'Book Room');
            }
            return _customCards(
              bgColor: const Color(0xFFF4DE5C),
              percentage: 0,
              title: 'Book Room',
              subTitle: '',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BookRoomScreen(),
                  ),
                );
              },
            );
          },
        ),
        StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore()
              .collection('users')
              .doc(cUser().uid)
              .collection('payment')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data!.docs;
            Provider.of<PaymentDetailsProvider>(context)
                .setPaymentPercentage(data.length);
            if (Provider.of<PaymentDetailsProvider>(context)
                    .getPaymentDetailsPercentage ==
                100) {
              return _customCompletedCard(
                  bgColor: const Color(0xFF0FD49F), title: 'Payment');
            }
            return _customCards(
              bgColor: const Color(0xFF0FD49F),
              percentage: 0,
              title: 'Payment',
              subTitle: '',
              onTap: () {
                AuthServices().savePaymentDetails();
              },
            );
          },
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('allotmentRequests')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var requests = snapshot.data!.docs;
            if (requests.isNotEmpty) {
              for (var element in requests) {
                if (element['studentUid'] == cUser().uid &&
                    element['status'] == 'confirm') {
                  return Card(
                    color: const Color(0xFFEE3963),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Confirm Room\nAllotment',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.grey[600],
                                ),
                              ),
                              // below subTitle
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(60),
                                width: getProportionateScreenHeight(60),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: Colors.white24,
                                      value: 100 / 100,
                                      color: Colors.black,
                                      strokeWidth:
                                          getProportionateScreenWidth(5),
                                    ),
                                    Center(
                                      child: Text(
                                        '100%',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(5)),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(5),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Go to Home\nScreen',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenWidth(15)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (element['studentUid'] == cUser().uid &&
                    element['status'] == 'pending') {
                  return _customCards(
                    bgColor: const Color(0xFFEE3963),
                    percentage: 0,
                    title: 'Confirm Room\nAllotment',
                    subTitle: '',
                    isPending: true,
                    onTap: () {
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //       builder: (context) => const HomeScreen(),
                      //     ),
                      //     (route) => false);
                    },
                  );
                }
              }
            }
            return _customCards(
              bgColor: const Color(0xFFEE3963),
              percentage: 0,
              title: 'Confirm Room\nAllotment',
              subTitle: '',
              onTap: () {
                var cc =
                    Provider.of<CurrentUserProvider>(context, listen: false)
                        .getUserData;
                AuthServices()
                    .sendAllotmentRequest(cc['roomNo'] ?? 'N007', 'EnTC');
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (context) => const HomeScreen(),
                //     ),
                //     (route) => false);
              },
            );
          },
        ),
      ],
    );
  }

  Card _customCompletedCard({required Color bgColor, required String title}) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              FontAwesomeIcons.checkDouble,
              size: getProportionateScreenWidth(30),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Card _customCards({
    isPending = false,
    required String title,
    required String subTitle,
    required int percentage,
    required Color bgColor,
    required void Function() onTap,
  }) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.grey[600],
                  ),
                ),
                // below subTitle
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(60),
                  width: getProportionateScreenHeight(60),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.white24,
                        value: percentage / 100,
                        color: Colors.black,
                        strokeWidth: getProportionateScreenWidth(5),
                      ),
                      Center(
                        child: Text(
                          '$percentage%',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                InkWell(
                  onTap: isPending ? () {} : onTap,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isPending ? 'Pending' : 'Complete',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(15)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

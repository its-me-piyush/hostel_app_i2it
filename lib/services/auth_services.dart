import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/screens/home/home_screen.dart';
import 'package:hostel_app_i2it/screens/hostelDetails/hostel_details_screen.dart';

import '../constants.dart';
import '../screens/sign_in/sign_in_screen.dart';

class AuthServices {
  handelAuth() {
    return StreamBuilder(
      stream: auth().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          StreamBuilder<QuerySnapshot>(
            stream:
                firebaseFirestore().collection('allotmentRequests').snapshots(),
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
              var totalRequest = snapshot.data!.docs;
              bool currentRequest = false;
              for (var element in totalRequest) {
                if (element['studentUid'] == cUser().uid) {
                  currentRequest = true;
                } else {
                  currentRequest = false;
                }
              }
              if (currentRequest) {
                return const HomeScreen();
              }

              return const HostelDetailsScreen();
            },
          );
        }
        return const SignInScreen();
      },
    );
  }

  signIn(BuildContext context, String irn, String password) async {
    var document = firebaseFirestore().collection('userList').doc(irn);
    return document.get().then((value) async {
      await auth()
          .signInWithEmailAndPassword(
              email: value.data()!['email'], password: password)
          .catchError((error, stackTrace) {
        ErrorHandler().errorDialog(context, error.message);
      });
    });
  }

  signup(String email, String pass, String irn) async {
    return await auth()
        .createUserWithEmailAndPassword(email: email, password: pass);
  }

  setGender(String gender) async {
    await firebaseFirestore().collection('users').doc(cUser().uid).update({
      'Gender': gender.toLowerCase(),
    });
  }

  saveUserDetails(String firstName, String lastName, String pn) async {
    await firebaseFirestore().collection('users').doc(cUser().uid).update({
      'name': firstName.trim() + ' ' + lastName.trim(),
      'phoneNumber': '+91' + pn,
    });
    await auth()
        .currentUser!
        .updateDisplayName(firstName.trim() + ' ' + lastName.trim());
    return await auth().verifyPhoneNumber(
      phoneNumber: '+91' + pn,
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (error) {},
      codeSent: (verificationId, resendingToken) {
        veriId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  savePersonalInfo(
      {required String picked,
      required String irn,
      required String year}) async {
    await firebaseFirestore()
        .collection('users')
        .doc(cUser().uid)
        .collection('Forms')
        .doc('personalForm')
        .set({
      'date_of_birth': picked,
      'profileImage': cUser().photoURL,
      'studentName': cUser().displayName,
      'irn': irn,
      'year': '3rd'
    });
  }

  saveParentGuardianInfo(
      {required String parentName,
      required String address,
      required String contact,
      required String guardianName,
      required String guardianAddress,
      required String guardianContact}) async {
    await firebaseFirestore()
        .collection('users')
        .doc(cUser().uid)
        .collection('Forms')
        .doc('parentGuardianInfo')
        .set({
      'parent_name': parentName,
      'parent_adress': address,
      'parent_contact': int.parse(contact),
      'guardian_name': guardianName,
      'guardian_adress': guardianAddress,
      'guardian_contact': int.parse(guardianContact),
    });
  }

  saveMedicalInfo(
      {required String gender,
      required String bloodGroup,
      required String allergies}) async {
    await firebaseFirestore()
        .collection('users')
        .doc(cUser().uid)
        .collection('Forms')
        .doc('medicalInfo')
        .set({
      'gender': gender,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
    });
  }

  Future savePaymentDetails() async {
    await firebaseFirestore()
        .collection('users')
        .doc(cUser().uid)
        .collection('payment')
        .doc()
        .set({
      'paymentStatus': 'Completed',
    });
  }

  Future saveBookedRoomDetails(
      String bookedRoomUid, int previousBooked, String bookedRoomNo) async {
    await firebaseFirestore()
        .collection('users')
        .doc(cUser().uid)
        .collection('allottedRoom')
        .doc()
        .set({
      'RoomID': bookedRoomUid,
    });
    await firebaseFirestore().collection('users').doc(cUser().uid).update({
      'bookedRoomNo': bookedRoomNo,
    });
    await firebaseFirestore().collection('rooms').doc(bookedRoomUid).update({
      'booked': previousBooked + 1,
    });
    await firebaseFirestore()
        .collection('rooms')
        .doc(bookedRoomUid)
        .collection('booked')
        .doc(cUser().uid)
        .set({
      'branch': 'EnTC',
      'occupant': cUser().displayName,
      'year': '3rd',
    });
  }

  checkForDuplicatePhoneNumber(
      String irn, String phoneNumber, List<dynamic> data) {
    for (var element in data) {
      if (element['phoneNumber'] == phoneNumber) {
        return true;
      }
    }
    return false;
  }

  signOut(BuildContext context) {
    auth().signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
  }

  sendAllotmentRequest(String roomNo, String branch) async {
    await firebaseFirestore()
        .collection('allotmentRequests')
        .doc(cUser().uid)
        .set({
      'status': 'pending',
      'studentPhotoUrl': cUser().photoURL,
      'studentUid': cUser().uid,
      'studentName': cUser().displayName,
      'studentBranch': branch,
      'studentRoomNo': roomNo,
    });
  }

  Future toggleLed(String ledNo, bool value, String roomNo) async {
    print(roomNo);
    final databaseReference = FirebaseDatabase.instance.ref();

    await databaseReference.child(roomNo).update(
      {
        ledNo: value,
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider with ChangeNotifier {
  final Map<String, dynamic> _user = {};

  setUserDetails(Object? data) {
    var d = data as Map<String, dynamic>;
    _user.addAll(d);
  }

  Map<String, dynamic> get getUserData {
    return {..._user};
  }
}

import 'package:flutter/material.dart';

class BookRoomProvider with ChangeNotifier {
  int _percentageCompleted = 0;

  changePercentageCompleted() {
    _percentageCompleted = 100;
  }

  void setBookedRoomPercentage(int index) {
    if (index == 1) {
      _percentageCompleted = 100;
    }
  }

  int get getBookFormsPercentage {
    return _percentageCompleted;
  }
}

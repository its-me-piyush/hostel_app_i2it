import 'package:flutter/material.dart';

class PaymentDetailsProvider with ChangeNotifier {
  int _percentageCompleted = 0;

  changePercentageCompleted() {
    _percentageCompleted = 100;
  }

  void setPaymentPercentage(int index) {
    if (index == 1) {
      _percentageCompleted = 100;
    }
  }

  int get getPaymentDetailsPercentage {
    return _percentageCompleted;
  }
}

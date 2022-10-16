import 'package:flutter/cupertino.dart';
import 'package:hostel_app_i2it/screens/forms/components/medical_form.dart';
import 'package:hostel_app_i2it/screens/forms/components/parent_form.dart';
import 'package:hostel_app_i2it/screens/forms/forms.dart';

class FormsProvider with ChangeNotifier {
  int formListIndex = 0;
  final List<Map<String, dynamic>> _formsList = const [
    {'name': 'Personal Form', 'screen': Forms()},
    {'name': 'Parent Form', 'screen': ParentForm()},
    {'name': 'Medical Form', 'screen': MedicalForm()},
    {'name': 'Medical Form', 'screen': MedicalForm()},
  ];

  Widget get getFormsCurrentScreen {
    return _formsList[formListIndex]['screen'];
  }

  String get getFormsCurrentFormName {
    return _formsList[formListIndex]['name'];
  }

  int formsPercentage = 0;

  void setFromListIndex(int value) {
    formListIndex = value;
    switch (value) {
      case 1:
        formsPercentage = 33;
        break;
      case 2:
        formsPercentage = 67;

        break;
      case 3:
        formsPercentage = 100;
        break;
      default:
        formsPercentage = 0;
    }
    // notifyListeners();
  }

  int get getFormPercentage {
    return formsPercentage;
  }
}

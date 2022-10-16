import 'package:flutter/material.dart';

import 'package:hostel_app_i2it/components/default_button.dart';
import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/screens/forms/components/parent_form.dart';

import '../../../components/custom_divider.dart';
import '../../../constants.dart';
import '../../../services/auth_services.dart';
import '../../../size_config.dart';

class CustomPersonalForm extends StatefulWidget {
  const CustomPersonalForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomPersonalForm> createState() => _CustomPersonalFormState();
}

class _CustomPersonalFormState extends State<CustomPersonalForm> {
  void nextFunction(context) {
    if (cUser().photoURL == null) {
      ErrorHandler().errorDialog(context, haImageMissingError);
    } else if (selectedDate == '') {
      ErrorHandler().errorDialog(context, haDOBMissingError);
    } else {
      AuthServices()
          .savePersonalInfo(picked: selectedDate, irn: irn, year: '3rd');
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ParentForm(),
      ));
    }
  }

  String selectedDate = '';
  String irn = '';
  @override
  void initState() {
    firebaseFirestore()
        .collection('users')
        .doc(cUser().uid)
        .get()
        .then((value) {
      setState(() {
        irn = value.data()!['IRN'];
      });
    });

    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1997, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = '${picked.year}/${picked.month}/${picked.day}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _CustomNameForm(),
        const CustomDivider(),
        // Irn
        TextField(
          enabled: false,
          decoration: InputDecoration(
            label: Text(
              'IRN:',
              style: TextStyle(
                color: Colors.grey,
                // fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(20),
              ),
            ),
            hintText: irn,
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
        const CustomDivider(),
        // DOB
        _customDOBPicker(context),
        const CustomDivider(),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        // Course
        const _CustomCourseAndYearDisplay(),

        // Next button
        DefaultButton(
          press: () {
            nextFunction(context);
          },
          text: 'Continue',
        )
      ],
    );
  }

  Widget _customDOBPicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          label: Text(
            'Date of Birth:',
            style: TextStyle(
              color: Colors.grey,
              // fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          hintText: selectedDate == '' ? 'Select a Date' : selectedDate,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: getProportionateScreenWidth(20),
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class _CustomNameForm extends StatefulWidget {
  const _CustomNameForm({Key? key}) : super(key: key);

  @override
  __CustomNameFormState createState() => __CustomNameFormState();
}

class __CustomNameFormState extends State<_CustomNameForm> {
  final TextEditingController _nameController = TextEditingController();
  bool isNameEdit = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      controller: _nameController,
      decoration: InputDecoration(
        label: Text(
          'Username:',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: cUser().displayName,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: getProportionateScreenWidth(20),
        ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}

class _CustomCourseAndYearDisplay extends StatefulWidget {
  const _CustomCourseAndYearDisplay({Key? key}) : super(key: key);

  @override
  __CustomCourseAndYearDisplayState createState() =>
      __CustomCourseAndYearDisplayState();
}

class __CustomCourseAndYearDisplayState
    extends State<_CustomCourseAndYearDisplay> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      decoration: InputDecoration(
        label: Text(
          'Year:',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: '3rd',
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: getProportionateScreenWidth(20),
        ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }
}

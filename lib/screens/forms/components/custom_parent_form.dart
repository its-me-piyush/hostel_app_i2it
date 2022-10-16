import 'package:flutter/material.dart';

import 'package:hostel_app_i2it/errors/error_handler.dart';
import 'package:hostel_app_i2it/screens/forms/components/medical_form.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';

import '../../../components/custom_divider.dart';
import '../../../components/default_button.dart';
import '../../../size_config.dart';

class CustomParentForm extends StatefulWidget {
  const CustomParentForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomParentForm> createState() => _CustomParentFormState();
}

class _CustomParentFormState extends State<CustomParentForm> {
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentAddressController =
      TextEditingController();
  final TextEditingController _parentContactController =
      TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _guardianAddressController =
      TextEditingController();
  final TextEditingController _guardianContactController =
      TextEditingController();
  String hintparentContact = 'Parents Contact Number';
  String guardianContact = 'Guardians Contact Number';

  void nextFunction(context) {
    if (_parentNameController.text.isEmpty) {
      ErrorHandler().errorDialog(context, 'Please Fill Parent\'s Name');
    } else if (_parentAddressController.text.isEmpty) {
      ErrorHandler().errorDialog(context, 'Please Fill Parent\'s Address');
    } else if (_parentContactController.text.isEmpty) {
      ErrorHandler().errorDialog(context, 'Please Fill Parent\'s Contact');
    } else if (_parentContactController.text.trim().length != 10) {
      ErrorHandler().errorDialog(context, 'Contact number should be 10 digits');
    } else {
      AuthServices().saveParentGuardianInfo(
        parentName: _parentNameController.text.trim(),
        address: _parentAddressController.text.trim(),
        contact: _parentContactController.text.trim(),
        guardianName: _guardianNameController.text.trim().isEmpty
            ? _parentNameController.text.trim()
            : _guardianNameController.text.trim(),
        guardianAddress: _guardianAddressController.text.trim().isEmpty
            ? _parentAddressController.text.trim()
            : _guardianAddressController.text.trim(),
        guardianContact: _guardianContactController.text.trim().isEmpty
            ? _parentContactController.text.trim()
            : _guardianContactController.text.trim(),
      );
      

      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MedicalForm(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _customParentName(),
        const CustomDivider(),
        //Parent's Address
        _customParentAddress(),
        const CustomDivider(),
        //Parent's Phone Number
        _customParentContact(),
        const CustomDivider(),
        //Guardian Data
        _customGuardianName(),
        const CustomDivider(),
        //Parent's Address
        _customGuardianAddress(),
        const CustomDivider(),
        //Parent's Phone Number
        _customGuardianContact(),
        const CustomDivider(),
        // // Age
        // const _CustomAgeForm(),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),

        // Next button
        DefaultButton(
          press: () {
            nextFunction(context);
          },
          text: 'Continue',
        ),
      ],
    );
  }

// ░██████╗░  ██╗░░░██╗  ░█████╗░  ██████╗░  ██████╗░  ██╗  ░█████╗░  ███╗░░██╗
// ██╔════╝░  ██║░░░██║  ██╔══██╗  ██╔══██╗  ██╔══██╗  ██║  ██╔══██╗  ████╗░██║
// ██║░░██╗░  ██║░░░██║  ███████║  ██████╔╝  ██║░░██║  ██║  ███████║  ██╔██╗██║
// ██║░░╚██╗  ██║░░░██║  ██╔══██║  ██╔══██╗  ██║░░██║  ██║  ██╔══██║  ██║╚████║
// ╚██████╔╝  ╚██████╔╝  ██║░░██║  ██║░░██║  ██████╔╝  ██║  ██║░░██║  ██║░╚███║
// ░╚═════╝░  ░╚═════╝░  ╚═╝░░╚═╝  ╚═╝░░╚═╝  ╚═════╝░  ╚═╝  ╚═╝░░╚═╝  ╚═╝░░╚══╝

  TextField _customGuardianName() {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      controller: _guardianNameController,
      decoration: InputDecoration(
        label: Text(
          'Guardian Name:',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: 'Type Guardian Name',
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextField _customGuardianAddress() {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      controller: _guardianAddressController,
      maxLines: 4,
      maxLength: 150,
      decoration: InputDecoration(
        label: Text(
          'Address',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: 'Address (Optional)',
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextField _customGuardianContact() {
    return TextField(
      controller: _guardianContactController,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      decoration: InputDecoration(
        label: Text(
          'Guardian Contact:',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: guardianContact,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

// ██████╗░  ░█████╗░  ██████╗░  ███████╗  ███╗░░██╗  ████████╗
// ██╔══██╗  ██╔══██╗  ██╔══██╗  ██╔════╝  ████╗░██║  ╚══██╔══╝
// ██████╔╝  ███████║  ██████╔╝  █████╗░░  ██╔██╗██║  ░░░██║░░░
// ██╔═══╝░  ██╔══██║  ██╔══██╗  ██╔══╝░░  ██║╚████║  ░░░██║░░░
// ██║░░░░░  ██║░░██║  ██║░░██║  ███████╗  ██║░╚███║  ░░░██║░░░
// ╚═╝░░░░░  ╚═╝░░╚═╝  ╚═╝░░╚═╝  ╚══════╝  ╚═╝░░╚══╝  ░░░╚═╝░░░

  TextField _customParentName() {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      controller: _parentNameController,
      decoration: InputDecoration(
        label: Text(
          'Parent Name:',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: 'Type Parents Name',
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextField _customParentAddress() {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      controller: _parentAddressController,
      maxLength: 150,
      maxLines: 4,
      decoration: InputDecoration(
        label: Text(
          'Address',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: 'Address (Required)',
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
  }

  TextField _customParentContact() {
    return TextField(
      controller: _parentContactController,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: getProportionateScreenWidth(20),
      ),
      decoration: InputDecoration(
        label: Text(
          'Contact:',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        hintText: hintparentContact,
        prefixText: '+91',
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

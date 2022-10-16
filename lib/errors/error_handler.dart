import 'package:flutter/material.dart';

import '../size_config.dart';

class ErrorHandler {
// ███████╗  ██████╗░  ██████╗░  ░█████╗░  ██████╗░
// ██╔════╝  ██╔══██╗  ██╔══██╗  ██╔══██╗  ██╔══██╗
// █████╗░░  ██████╔╝  ██████╔╝  ██║░░██║  ██████╔╝
// ██╔══╝░░  ██╔══██╗  ██╔══██╗  ██║░░██║  ██╔══██╗
// ███████╗  ██║░░██║  ██║░░██║  ╚█████╔╝  ██║░░██║
// ╚══════╝  ╚═╝░░╚═╝  ╚═╝░░╚═╝  ░╚════╝░  ╚═╝░░╚═╝

// ██████╗░  ██╗  ░█████╗░  ██╗░░░░░  ░█████╗░  ░██████╗░
// ██╔══██╗  ██║  ██╔══██╗  ██║░░░░░  ██╔══██╗  ██╔════╝░
// ██║░░██║  ██║  ███████║  ██║░░░░░  ██║░░██║  ██║░░██╗░
// ██║░░██║  ██║  ██╔══██║  ██║░░░░░  ██║░░██║  ██║░░╚██╗
// ██████╔╝  ██║  ██║░░██║  ███████╗  ╚█████╔╝  ╚██████╔╝
// ╚═════╝░  ╚═╝  ╚═╝░░╚═╝  ╚══════╝  ░╚════╝░  ░╚═════╝░
  Future errorDialog(BuildContext context, e) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Error'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(e),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ok'))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
// ██╗░░░░░  ░█████╗░  ░█████╗░  ██████╗░  ██╗  ███╗░░██╗  ░██████╗░
// ██║░░░░░  ██╔══██╗  ██╔══██╗  ██╔══██╗  ██║  ████╗░██║  ██╔════╝░
// ██║░░░░░  ██║░░██║  ███████║  ██║░░██║  ██║  ██╔██╗██║  ██║░░██╗░
// ██║░░░░░  ██║░░██║  ██╔══██║  ██║░░██║  ██║  ██║╚████║  ██║░░╚██╗
// ███████╗  ╚█████╔╝  ██║░░██║  ██████╔╝  ██║  ██║░╚███║  ╚██████╔╝
// ╚══════╝  ░╚════╝░  ╚═╝░░╚═╝  ╚═════╝░  ╚═╝  ╚═╝░░╚══╝  ░╚═════╝░

  Widget loading(BuildContext context, Widget bgWidget) {
    return Stack(
      children: <Widget>[
        bgWidget,
        Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(
            color: Colors.white70,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10.0)),
            width: SizeConfig.screenWidth * 0.8,
            height: getProportionateScreenHeight(300),
            alignment: AlignmentDirectional.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      value: null,
                      color: Colors.white,
                      strokeWidth: 5.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "loading.. wait...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

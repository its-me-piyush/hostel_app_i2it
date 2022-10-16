import 'package:flutter/material.dart';

class HomeMenuDone extends StatelessWidget {
  const HomeMenuDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Center(
          child: Text(
            'No data',
          ),
        ),
      ],
    );
  }
}

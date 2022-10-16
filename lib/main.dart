import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/routes.dart';
import '/theme.dart';
import 'provider/book_room_provider.dart';
import 'provider/current_user_provider.dart';
import 'provider/forms_provider.dart';
import 'provider/home_menu_provider.dart';
import 'provider/payment_details_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: FormsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: HomeMenuProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BookRoomProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PaymentDetailsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BookRoomProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CurrentUserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Hostel App',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        routes: routes,
        initialRoute: '/',
      ),
    );
  }
}

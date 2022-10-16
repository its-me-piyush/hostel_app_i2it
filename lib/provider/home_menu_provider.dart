import 'package:flutter/cupertino.dart';
import 'package:hostel_app_i2it/enums.dart';

import '../screens/hostelDetails/components/top_menu_controller/home_menu_done.dart';
import '../screens/hostelDetails/components/top_menu_controller/home_menu_help.dart';
import '../screens/hostelDetails/components/top_menu_controller/home_menu_processing.dart';
import '../screens/hostelDetails/components/top_menu_controller/home_menu_upcomming.dart';
class HomeMenuProvider with ChangeNotifier {
  HomeOptions currentSelected = HomeOptions.upcomming;

  Widget get getCurrentMenuWidget {
    switch (currentSelected) {
      case HomeOptions.upcomming:
        return const HomeMenuUpcomming();

      case HomeOptions.processing:
        return const HomeMenuProcessing();
      case HomeOptions.done:
        return const HomeMenuDone();
      case HomeOptions.help:
        return const HomeMenuHelp();
      default:
        return const HomeMenuUpcomming();
    }
  }

  HomeOptions get getCurrentMenuItemSelected {
    return currentSelected;
  }

  void changeSelected(HomeOptions homeOptions) {
    currentSelected = homeOptions;
    notifyListeners();
  }
}

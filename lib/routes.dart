import 'package:flutter/widgets.dart';
import 'package:hostel_app_i2it/screens/hostelDetails/hostel_details_screen.dart';
import '/services/auth_services.dart';
import '/screens/forms/forms.dart';
import '/screens/otp/otp_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import '/screens/sign_up/sign_up_screen.dart';
import '/screens/forgot_password/forgot_password_screen.dart';
import '/screens/complete_profile/complete_profile_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  '/': (context) => AuthServices().handelAuth(),
  Forms.routeName: (context) => const Forms(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HostelDetailsScreen.routeName: (context) => const HostelDetailsScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
};

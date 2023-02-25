import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce/screens/Bottom_nav_Screen.dart';
import 'package:flutter_e_commerce/screens/LogIn_Screen.dart';
import 'package:flutter_e_commerce/screens/On_Boarding_Screen.dart';
import 'package:flutter_e_commerce/screens/Register_Screen.dart';
import 'package:flutter_e_commerce/screens/Search_Screen.dart';
import 'package:flutter_e_commerce/screens/User_Form_Screen.dart';


Map<String, WidgetBuilder> getAppRoutes() {
  return {
    OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    RegisterScreen.routeName: (context) => RegisterScreen(),
    BottomNavScreen.routeName: (context) => BottomNavScreen(),
    UserFormScreen.routeName: (context) => UserFormScreen(),
    SearchScreen.routeName: (context) => SearchScreen(),
  };
}

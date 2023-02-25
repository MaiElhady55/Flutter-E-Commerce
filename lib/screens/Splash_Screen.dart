import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/consts/AppColors.dart';
import 'package:flutter_e_commerce/screens/On_Boarding_Screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushNamed(OnBoardingScreen.routeName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
          child: Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Text(
              'E-Commerce',
              style: TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            
            CircularProgressIndicator(color: Colors.white),
        ],
      ),
          )),
    );
  }
}

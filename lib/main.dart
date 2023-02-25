import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/routes/app_routes.dart';
import 'package:flutter_e_commerce/screens/Splash_Screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyBU_LxpW9VU1Mzbvd-VerE8uGWbW1fg8g4',
    appId: '1:521818955682:android:0c7e91b2fdc2beda3f1cfb',
    messagingSenderId: '521818955682',
    projectId: 'flutter-e-commerce-1072a')); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes:getAppRoutes(),
        );
  }
}

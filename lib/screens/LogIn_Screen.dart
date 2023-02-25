import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/consts/AppColors.dart';
import 'package:flutter_e_commerce/screens/Bottom_nav_Screen.dart';
import 'package:flutter_e_commerce/screens/Register_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/CustomButton.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'logIn Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsecure = true;

  signIn() async {
    try {
      
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.pushNamed(context, BottomNavScreen.routeName);
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: appSize.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.light,
                          color: Colors.transparent,
                        )),
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: appSize.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 22, color: AppColors.deep_orange),
                      ),
                      Text(
                        "Glad to see you back my buddy.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          BuildContainer(
                            icon: Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "thed9954@gmail.com",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF414041),
                              ),
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: AppColors.deep_orange,
                              ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          BuildContainer(
                              icon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 20,
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: obsecure,
                              decoration: InputDecoration(
                                hintText: "password must be 6 character",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.deep_orange,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obsecure = !obsecure;
                                    });
                                  },
                                  icon: Icon(obsecure == true
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      customButton('SIGN IN', () {
                        signIn();
                      }, context),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                        GestureDetector(
                            child: Text(
                              " Sign Up",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deep_orange,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            }),
                      ])
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Container BuildContainer({required Widget icon}) {
    return Container(
      width: 48,
      height: 41,
      decoration: BoxDecoration(
        color: AppColors.deep_orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}

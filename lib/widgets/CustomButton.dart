import 'package:flutter/material.dart';

import '../consts/AppColors.dart';

Widget customButton(
    String buttonText, void Function() onPressed, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 56,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
    ),
    child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.deep_orange),
          elevation: MaterialStateProperty.all(3),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
  );
}

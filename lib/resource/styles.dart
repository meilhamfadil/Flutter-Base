import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/resource/color.dart';

class AppStyles {
  static InputDecoration formLogin = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 10),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.dark),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.danger),
    ),
    errorStyle: TextStyle(
      color: AppColor.danger,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.danger),
    ),
  );
}

class AppWidget {
  static SizedBox smallLoading = SizedBox(
    width: 15,
    height: 15,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );
}

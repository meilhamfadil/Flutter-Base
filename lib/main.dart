import 'package:flutter/material.dart';
import 'package:flutterfirebase/presentation/main_apps.dart';
import 'package:flutterfirebase/resource/routes.dart';
import 'package:flutterfirebase/resource/string.dart';

void main() => runApp(
      MaterialApp(
        title: AppString.appName,
        home: MainApps(),
        debugShowCheckedModeBanner: false,
//        initialRoute: Routes.initialPage,
//        routes: Routes.pages,
      ),
    );

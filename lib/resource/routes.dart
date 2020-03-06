import 'package:flutter/cupertino.dart';
import 'package:flutterfirebase/presentation/auth/auth.dart';
import 'package:flutterfirebase/presentation/main_apps.dart';

class Routes {
  static String initialPage = "/";
  static Map<String, WidgetBuilder> pages = {
    "/": (BuildContext context) => MainApps(),
    "/": (BuildContext context) => MainApps(),
    "/auth": (BuildContext context) => Auth()
  };
}

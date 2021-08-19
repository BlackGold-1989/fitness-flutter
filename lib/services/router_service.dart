import 'package:fitness/screens/auth/login_screen.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/screens/splash_screen.dart';
import 'package:fitness/utils/constants.dart';
import 'package:flutter/material.dart';

class RouteService {
  static getRoutes() {
    return <String, WidgetBuilder>{
      Constants.route_splash: (context) => SplashScreen(),
      Constants.route_login: (context) => LoginScreen(),
      Constants.route_main: (context) => MainScreen(),
    };
  }
}

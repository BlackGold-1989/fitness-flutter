import 'dart:async';

import 'package:fitness/services/network_service.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.run(() {
      checkData();
    });
  }

  void checkData() async {
    var token = await PrefService().getToken();
    if (token.isEmpty) {
      Navigator.of(context)
          .pushReplacementNamed(Constants.route_login, arguments: 0);
    } else {
      var resp = await NetworkService(context)
          .ajax('Auth', 'fitness_check_token', {}, isProgress: false);
      if (resp['ret'] == 10000) {
        Navigator.of(context)
            .pushReplacementNamed(Constants.route_main, arguments: 0);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(Constants.route_login, arguments: 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage('assets/images/img_splash.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}

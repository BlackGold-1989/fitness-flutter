import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:fitness/services/pref_service.dart';
import 'package:fitness/services/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'utils/constants.dart';

final ReceivePort port = ReceivePort();
const String isolateName = 'isolate';
const String countKey = 'count';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();

    IsolateNameServer.registerPortWithName(
      port.sendPort,
      isolateName,
    );

    if (await PrefService().containKey(Constants.keyAlarmCounter)) {
      await PrefService().setAlarmCount(0);
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Fitness',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blueAccent),
      themeMode: ThemeMode.dark,
      initialRoute: Constants.route_splash,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: RouteService.getRoutes(),
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

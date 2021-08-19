import 'dart:convert';

import 'package:fitness/models/alarm.dart';
import 'package:fitness/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getLanguage() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyLanguage) ?? 'English';
  }

  Future setLanguage(String lang) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyLanguage, lang);
  }

  Future<bool> isMale() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(Constants.keyGender) ?? true;
  }

  Future setGender(bool isMale) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(Constants.keyLanguage, isMale);
  }

  Future<List<Alarm>> getAlarms() async {
    final SharedPreferences prefs = await _prefs;
    String data = prefs.getString(Constants.keyAlarms);
    if (data == null || data.isEmpty) return [];

    List<Alarm> alarms = [];
    var jsonData = jsonDecode(data);
    for (var json in jsonData) {
      var alarm = Alarm.fromMap(json);
      alarms.add(alarm);
    }

    return alarms;
  }

  Future setAlarms(List<Alarm> alarms) async {
    final SharedPreferences prefs = await _prefs;
    var jsonData = [];
    for (var alarm in alarms) {
      jsonData.add(alarm.toMap());
    }

    prefs.setString(Constants.keyAlarms, jsonEncode(jsonData));
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyToken) ?? '';
  }

  Future setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyToken, token);
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyEmail) ?? '';
  }

  Future setEmail(String email) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyEmail, email);
  }

  Future<String> getPassword() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.keyPassword) ?? '';
  }

  Future setPassword(String pass) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.keyPassword, pass);
  }

  Future<int> getAlarmCounter() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(Constants.keyAlarmCounter) ?? 0;
  }

  Future setAlarmCount(int count) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(Constants.keyPassword, count);
  }

  Future logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  Future<bool> containKey(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key);
  }
}

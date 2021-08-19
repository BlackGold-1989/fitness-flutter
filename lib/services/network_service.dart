import 'dart:convert';

import 'package:fitness/services/pref_service.dart';
import 'package:fitness/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

const String DOMAIN = 'fitness.laodev.info';

const String avatarUrl = 'https://' + DOMAIN + '/uploads/ic_avatar.png';
const String imgBaseUrl = 'https://' + DOMAIN + '/uploads/images/';
const String videoBaseUrl = 'https://' + DOMAIN + '/uploads/images/';

const String privacyUrl = 'https://privacy.laodev.info/fitness.php';
const String userAgreeUrl = 'https://privacy.laodev.info/fitness.php';

class NetworkService {
  final BuildContext context;

  NetworkService(this.context);

  Future<dynamic> ajax(
      String header, String link, Map<String, dynamic> parameter,
      {bool isProgress = false, bool isFullUrl = false}) async {
    if (isProgress && context != null) LoadService().showLoading(context);

    var url = Uri.https(DOMAIN, '/$header/' + link, {'q': '{https}'});

    print('===== [http] request link ====> \n${url.toString()}');

    var token = await PrefService().getToken();
    if (token.isNotEmpty) {
      parameter['token'] = token;
    }
    print('===== [http] request params ====> \n${parameter.toString()}');

    final response = await http
        .post(
          url,
          body: parameter,
        )
        .timeout(Duration(minutes: 3));
    if (isProgress && context != null) LoadService().hideLoading(context);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('===== [http] $link response ====> \n${response.body}');
      var json = jsonDecode(response.body);
      if (json['ret'] == 9999) {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(Constants.route_login));
        return;
      }
      return json;
    } else {
      print('===== [http] $link failed ====>  ${response.statusCode}');
      Exception(response.statusCode);
    }
  }
}

bool isShowing = false;

class LoadService {
  bool hideLoading(BuildContext context) {
    if (context == null) {
      return true;
    }
    isShowing = false;
    Navigator.of(context).pop(true);
    return true;
  }

  bool showLoading(BuildContext context) {
    if (context == null) {
      return true;
    }
    isShowing = true;
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        },
        useRootNavigator: false);
    return true;
  }

  void showScheduledLoading(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => showLoading(context));
  }
}

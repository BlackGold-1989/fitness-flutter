import 'package:fitness/utils/constants.dart';
import 'package:flutter/services.dart';

class CommonService {
  static var platform_apple_sign = const MethodChannel('${Constants.const_packet_name}/apple_sign');

  static Future<String> initAppleSign() async {
    print('init [APPLE]]');
    final result = await platform_apple_sign.invokeMethod('init','');
    print('[APPLE] response:' + String.fromCharCodes(result));
    return String.fromCharCodes(result);
  }

}
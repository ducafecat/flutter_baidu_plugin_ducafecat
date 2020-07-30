import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBaiduPluginDucafecat {
  static const MethodChannel _channel =
      const MethodChannel('flutter_baidu_plugin_ducafecat');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> duAddOne(int num) async {
    final int val = await _channel.invokeMethod('duAddOne', {"num": num});
    return val;
  }
}

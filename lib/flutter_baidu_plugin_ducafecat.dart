import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

class FlutterBaiduPluginDucafecat {
  /// flutter端主动调用原生端方法
  static const MethodChannel _channel =
      const MethodChannel('flutter_baidu_plugin_ducafecat');

  /// 原生端主动回传结果数据到flutter端
  static const EventChannel _stream =
      const EventChannel("flutter_baidu_plugin_ducafecat_stream");

  /// ios 下设置 key
  /// android 在 AndroidManifest.xml 中设置
  static Future<bool> setApiKeyForIOS(String key) async {
    return await _channel.invokeMethod("setApiKey", key);
  }

  /// 设置定位参数
  void prepareLoc(Map androidMap, Map iosMap) {
    Map map;
    if (Platform.isAndroid) {
      map = androidMap;
    } else {
      map = iosMap;
    }
    _channel.invokeMethod("updateOption", map);
    return;
  }

  /// 启动定位
  void startLocation() {
    _channel.invokeMethod('startLocation');
    return;
  }

  /// 停止定位
  void stopLocation() {
    _channel.invokeMethod('stopLocation');
    return;
  }

  /// 原生端回传键值对map到flutter端
  /// map中key为isInChina对应的value，如果为1则判断是在国内，为0则判断是在国外
  /// map中存在key为nearby则判断为已到达设置监听位置附近
  Stream<Map<String, Object>> onResultCallback() {
    Stream<Map<String, Object>> _resultMap;
    if (_resultMap == null) {
      _resultMap = _stream.receiveBroadcastStream().map<Map<String, Object>>(
          (element) => element.cast<String, Object>());
    }
    return _resultMap;
  }
}

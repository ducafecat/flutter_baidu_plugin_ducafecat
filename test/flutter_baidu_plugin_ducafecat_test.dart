import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_baidu_plugin_ducafecat/flutter_baidu_plugin_ducafecat.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_baidu_plugin_ducafecat');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterBaiduPluginDucafecat.platformVersion, '42');
  });
}

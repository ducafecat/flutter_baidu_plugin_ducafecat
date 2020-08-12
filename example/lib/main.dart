import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_baidu_plugin_ducafecat/flutter_baidu_plugin_ducafecat.dart';
import 'package:flutter_baidu_plugin_ducafecat_example/views/location-view.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermission(); // 执行权限请求

    if (Platform.isIOS == true) {
      FlutterBaiduPluginDucafecat.setApiKeyForIOS(
          "dkYT07blcAj3drBbcN1eGFYqt16HP1pR");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 动态申请定位权限
  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();

    return statuses[Permission.location].isGranted &&
        statuses[Permission.storage].isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "location_view": (context) => LocationView(),
      },
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('地图插件')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('定位信息'),
              subtitle: Text('点击开始后，百度地图实时推送经纬度信息'),
              leading: Icon(Icons.location_searching),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.pushNamed(context, "location_view");
              },
            )
          ],
        ),
      ),
    );
  }
}

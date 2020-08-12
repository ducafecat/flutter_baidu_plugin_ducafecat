# Flutter Baidu Plugin 百度地图插件

[x] 实时获取经纬度

[ ] 定位我的位置

[ ] 地图标记

[ ] 地图绘制线

[ ] 地图截图

[ ] 搜索关键字

[ ] 调整百度、高德地图导航

## 安装

```yaml
flutter_baidu_plugin_ducafecat:
  git:
    url: https://github.com/ducafecat/flutter_baidu_plugin_ducafecat
    version: ^x.x.x 最新版本
```

## 使用说明

### 百度 AK

- 官方

https://lbsyun.baidu.com/apiconsole/key#/home

- android/app/src/main/AndroidManifest.xml

```xml
        <!-- 在这里设置android端ak-->
        <meta-data
            android:name="com.baidu.lbsapi.API_KEY"
            android:value="aCUtcLDufllGi4nEaKgU8FmBqufFyekh" />

    </application>
</manifest>
```

### android 配置

- 文档

http://lbsyun.baidu.com/index.php?title=android-locsdk/guide/create-project/android-studio

- android/src/main/AndroidManifest.xml

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
  package="tech.ducafecat.flutter_baidu_plugin_ducafecat">
    <!-- 这个权限用于进行网络定位-->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"></uses-permission>
    <!-- 这个权限用于访问GPS定位-->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"></uses-permission>
    <!-- 用于访问wifi网络信息，wifi信息会用于进行网络定位-->
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"></uses-permission>
    <!-- 获取运营商信息，用于支持提供运营商信息相关的接口-->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"></uses-permission>
    <!-- 这个权限用于获取wifi的获取权限，wifi信息会用来进行网络定位-->
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE"></uses-permission>
    <!-- 用于读取手机当前的状态-->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"></uses-permission>
    <!-- 写入扩展存储，向扩展卡写入数据，用于写入离线定位数据-->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"></uses-permission>
    <!-- 访问网络，网络定位需要上网-->
    <uses-permission android:name="android.permission.INTERNET" />

    <!-- 读取系统信息，包含系统版本等信息，用作统计-->
    <uses-permission android:name="com.android.launcher.permission.READ_SETTINGS" />
    <!-- 程序在手机屏幕关闭后后台进程仍然运行-->
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <application>
        <!-- 声明service组件 -->
        <service
            android:name="com.baidu.location.f"
            android:enabled="true"
            android:process=":remote" >
        </service>
    </application>
</manifest>
```

### ios 配置

- Info.plist

```
NSLocationWhenInUseUsageDescription 需要定位
```

### 动态授权

- pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter

  ...

  permission_handler: ^5.0.1+1
```

- lib/main.dart

```dart
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestPermission(); // 执行权限请求
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
}
```

### 地图定位

代码例子

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_plugin_ducafecat/entity/flutter_baidu_location.dart';
import 'package:flutter_baidu_plugin_ducafecat/entity/flutter_baidu_location_android_option.dart';
import 'package:flutter_baidu_plugin_ducafecat/entity/flutter_baidu_location_ios_option.dart';
import 'package:flutter_baidu_plugin_ducafecat/flutter_baidu_plugin_ducafecat.dart';

class LocationView extends StatefulWidget {
  LocationView({Key key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  FlutterBaiduPluginDucafecat _locationPlugin = FlutterBaiduPluginDucafecat();
  StreamSubscription<Map<String, Object>> _locationListener; // 事件监听
  BaiduLocation _baiduLocation; // 经纬度信息
  // Map<String, Object> _loationResult; // 返回格式数据

  @override
  void dispose() {
    super.dispose();

    // 取消监听
    if (null != _locationListener) {
      _locationListener.cancel();
    }
  }

  // 返回定位信息
  void _setupListener() {
    if (_locationListener != null) {
      return;
    }
    _locationListener =
        _locationPlugin.onResultCallback().listen((Map<String, Object> result) {
      setState(() {
        // _loationResult = result;
        try {
          _baiduLocation = BaiduLocation.fromMap(result);
          print(_baiduLocation);
        } catch (e) {
          print(e);
        }
      });
    });
  }

  // 设置android端和ios端定位参数
  void _setLocOption() {
    // android 端设置定位参数
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(1000); // 设置发起定位请求时间间隔

    Map androidMap = androidOption.getMap();

    // ios 端设置定位参数
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    iosOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    iosOption.setBMKLocationCoordinateType(
        "BMKLocationCoordinateTypeBMK09LL"); // 设置返回的位置坐标系类型
    iosOption.setActivityType("CLActivityTypeAutomotiveNavigation"); // 设置应用位置类型
    iosOption.setLocationTimeout(10); // 设置位置获取超时时间
    iosOption.setDesiredAccuracy("kCLLocationAccuracyBest"); // 设置预期精度参数
    iosOption.setReGeocodeTimeout(10); // 设置获取地址信息超时时间
    iosOption.setDistanceFilter(100); // 设置定位最小更新距离
    iosOption.setAllowsBackgroundLocationUpdates(true); // 是否允许后台定位
    iosOption.setPauseLocUpdateAutomatically(true); //  定位是否会被系统自动暂停

    Map iosMap = iosOption.getMap();

    _locationPlugin.prepareLoc(androidMap, iosMap);
  }

  // 启动定位
  void _handleStartLocation() {
    if (null != _locationPlugin) {
      _setupListener();
      _setLocOption();
      _locationPlugin.startLocation();
    }
  }

  // 停止定位
  void _handleStopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
      setState(() {
        _baiduLocation = null;
      });
    }
  }

  ////////////////////////////////////////////////////////////

  // 显示地理信息
  Widget _buildLocationView() {
    return _baiduLocation != null
        ? Table(
            children: [
              TableRow(children: [
                TableCell(child: Text('经度')),
                TableCell(child: Text(_baiduLocation.longitude.toString())),
              ]),
              TableRow(children: [
                TableCell(child: Text('纬度')),
                TableCell(child: Text(_baiduLocation.latitude.toString())),
              ]),
              TableRow(children: [
                TableCell(child: Text('国家')),
                TableCell(
                    child: Text(_baiduLocation.country != null
                        ? _baiduLocation.country
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('省份')),
                TableCell(
                    child: Text(_baiduLocation.province != null
                        ? _baiduLocation.province
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('城市')),
                TableCell(
                    child: Text(_baiduLocation.city != null
                        ? _baiduLocation.city
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('区县')),
                TableCell(
                    child: Text(_baiduLocation.district != null
                        ? _baiduLocation.district
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('街道')),
                TableCell(
                    child: Text(_baiduLocation.street != null
                        ? _baiduLocation.street
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('地址')),
                TableCell(
                    child: Text(_baiduLocation.address != null
                        ? _baiduLocation.address
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('位置语义化描述')),
                TableCell(
                    child: Text(_baiduLocation.locationDetail != null
                        ? _baiduLocation.locationDetail
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('周边poi信息')),
                TableCell(
                    child: Text(_baiduLocation.poiList != null
                        ? _baiduLocation.poiList
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('错误码')),
                TableCell(
                    child: Text(_baiduLocation.errorCode != null
                        ? _baiduLocation.errorCode.toString()
                        : "")),
              ]),
              TableRow(children: [
                TableCell(child: Text('定位失败描述信息')),
                TableCell(
                    child: Text(_baiduLocation.errorInfo != null
                        ? _baiduLocation.errorInfo
                        : "")),
              ]),
            ],
          )
        : Container();
  }

  // 控制面板
  Widget _buildControlPlan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: _baiduLocation == null ? _handleStartLocation : null,
          child: Text('开始定位'),
        ),
        MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: _baiduLocation != null ? _handleStopLocation : null,
          child: Text('暂停定位'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('定位信息'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildControlPlan(),
            Divider(),
            _buildLocationView(),
          ],
        ),
      ),
    );
  }
}
```

## 视频指导

## 常见错误

### ios

- 设置 Info.plist NSLocationWhenInUseUsageDescription 需要定位

```
reason	__NSCFConstantString *	"To use location in iOS8 you need to define either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription in the app bundle's Info.plist file"	0x00000001023b5278
```

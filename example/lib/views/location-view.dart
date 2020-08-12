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

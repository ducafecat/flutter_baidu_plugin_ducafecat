/// 百度定位结果类，用于存储各类定位结果信息
class BaiduLocation {
  /// 定位成功时间
  final String locTime;

  /// 定位结果类型
  final int locType;

  /// 半径
  final double radius;

  /// 纬度
  final double latitude;

  /// 经度
  final double longitude;

  /// 海拔
  final double altitude;

  /// 国家
  final String country;

  /// 省份
  final String province;

  /// 城市
  final String city;

  /// 区县
  final String district;

  /// 街道
  final String street;

  /// 地址
  final String address;

  /// 位置语义化描述，例如"在百度大厦附近"
  final String locationDetail;

  /// 周边poi信息，每个poi之间用"|"隔开

  final String poiList;

  /// 定位结果回调时间
  final String callbackTime;

  /// 错误码
  final int errorCode;

  /// 定位失败描述信息
  final String errorInfo;

  BaiduLocation(
      {this.locTime,
      this.locType,
      this.radius,
      this.latitude,
      this.longitude,
      this.altitude,
      this.country,
      this.province,
      this.city,
      this.district,
      this.street,
      this.address,
      this.locationDetail,
      this.poiList,
      this.callbackTime,
      this.errorCode,
      this.errorInfo});

  /// 根据传入的map生成BaiduLocation对象
  factory BaiduLocation.fromMap(dynamic value) {
    return new BaiduLocation(
      locTime: value['locTime'],
      locType: value['locType'],
      radius: value['radius'],
      latitude: value['latitude'],
      longitude: value['longitude'],
      altitude: value['altitude'],
      country: value['country'],
      province: value['province'],
      city: value['city'],
      district: value['district'],
      street: value['street'],
      address: value['address'],
      locationDetail: value['locationDetail'],
      poiList: value['poiList'],
      callbackTime: value['callbackTime'],
      errorCode: value['errorCode'],
      errorInfo: value['errorInfo'],
    );
  }

  /// 获取对本类所有变量赋值后的map键值对
  Map getMap() {
    return {
      "locTime": locTime,
      "locType": locType,
      "radius": radius,
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "country": country,
      "province": province,
      "city": city,
      "district": district,
      "street": street,
      "address": address,
      "locationDescribe": locationDetail,
      "poiList": poiList,
      "callbackTime": callbackTime,
      "errorCode": errorCode,
      "errorInfo": errorInfo,
    };
  }
}

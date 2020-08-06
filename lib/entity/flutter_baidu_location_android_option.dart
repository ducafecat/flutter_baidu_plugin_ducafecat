/// 设置android端定位参数类
class BaiduLocationAndroidOption {
  /// 坐标系类型
  String coorType;

  /// 是否需要返回地址信息
  bool isNeedAddres;

  /// 是否需要返回海拔高度信息
  bool isNeedAltitude;

  /// 是否需要返回周边poi信息
  bool isNeedLocationPoiList;

  /// 是否需要返回新版本rgc信息
  bool isNeedNewVersionRgc;

  /// 是否需要返回位置描述信息
  bool isNeedLocationDescribe;

  /// 是否使用gps
  bool openGps;

  /// 可选，设置发起定位请求的间隔，int类型，单位ms
  /// 如果设置为0，则代表单次定位，即仅定位一次，默认为0
  /// 如果设置非0，需设置1000ms以上才有效
  int scanspan;

  /// 设置定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
  int locationMode;

  /// 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
  int locationPurpose;

  /// 可选，设置返回经纬度坐标类型，默认GCJ02
  /// GCJ02：国测局坐标；
  /// BD09ll：百度经纬度坐标；
  /// BD09：百度墨卡托坐标；
  /// 海外地区定位，无需设置坐标类型，统一返回WGS84类型坐标
  void setCoorType(String coorType) {
    this.coorType = coorType;
  }

  /// 是否需要返回地址信息
  void setIsNeedAddres(bool isNeedAddres) {
    this.isNeedAddres = isNeedAddres;
  }

  /// 是否需要返回海拔高度信息
  void setIsNeedAltitude(bool isNeedAltitude) {
    this.isNeedAltitude = isNeedAltitude;
  }

  /// 是否需要返回周边poi信息
  void setIsNeedLocationPoiList(bool isNeedLocationPoiList) {
    this.isNeedLocationPoiList = isNeedLocationPoiList;
  }

  /// 是否需要返回位置描述信息
  void setIsNeedLocationDescribe(bool isNeedLocationDescribe) {
    this.isNeedLocationDescribe = isNeedLocationDescribe;
  }

  /// 是否需要返回新版本rgc信息
  void setIsNeedNewVersionRgc(bool isNeedNewVersionRgc) {
    this.isNeedNewVersionRgc = isNeedNewVersionRgc;
  }

  /// 是否使用gps
  void setOpenGps(bool openGps) {
    this.openGps = openGps;
  }

  /// 可选，设置发起定位请求的间隔，int类型，单位ms
  /// 如果设置为0，则代表单次定位，即仅定位一次，默认为0
  /// 如果设置非0，需设置1000ms以上才有效
  void setScanspan(int scanspan) {
    this.scanspan = scanspan;
  }

  /// 设置定位模式，可选的模式有高精度、仅设备、仅网络，默认为高精度模式
  void setLocationMode(LocationMode locationMode) {
    if (locationMode == LocationMode.Hight_Accuracy) {
      this.locationMode = 1;
    } else if (locationMode == LocationMode.Device_Sensors) {
      this.locationMode = 2;
    } else if (locationMode == LocationMode.Battery_Saving) {
      this.locationMode = 3;
    }
  }

  /// 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
  void setLocationPurpose(BDLocationPurpose locationPurpose) {
    if (locationPurpose == BDLocationPurpose.SignIn) {
      this.locationPurpose = 1;
    } else if (locationPurpose == BDLocationPurpose.Transport) {
      this.locationPurpose = 2;
    } else if (locationPurpose == BDLocationPurpose.Sport) {
      this.locationPurpose = 3;
    }
  }

  BaiduLocationAndroidOption(
      {this.coorType,
      this.isNeedAddres,
      this.isNeedAltitude,
      this.isNeedLocationPoiList,
      this.isNeedNewVersionRgc,
      this.openGps,
      this.isNeedLocationDescribe,
      this.scanspan,
      this.locationMode,
      this.locationPurpose});

  /// 根据传入的map生成BaiduLocationAndroidOption对象
  factory BaiduLocationAndroidOption.fromMap(dynamic value) {
    return new BaiduLocationAndroidOption(
      coorType: value['coorType'],
      isNeedAddres: value['isNeedAddres'],
      isNeedAltitude: value['isNeedAltitude'],
      isNeedLocationPoiList: value['isNeedLocationPoiList'],
      isNeedNewVersionRgc: value['isNeedNewVersionRgc'],
      openGps: value['openGps'],
      isNeedLocationDescribe: value[''],
      scanspan: value['scanspan'],
      locationMode: value['locationMode'],
      locationPurpose: value['LocationPurpose'],
    );
  }

  /// 获取对本类所有变量赋值后的map键值对
  Map getMap() {
    return {
      "coorType": coorType,
      "isNeedAddres": isNeedAddres,
      "isNeedAltitude": isNeedAltitude,
      "isNeedLocationPoiList": isNeedLocationPoiList,
      "isNeedNewVersionRgc": isNeedNewVersionRgc,
      "openGps": openGps,
      "isNeedLocationDescribe": isNeedLocationDescribe,
      "scanspan": scanspan,
      "locationMode": locationMode,
    };
  }
}

/// 定位模式枚举类
enum LocationMode {
  /// 高精度模式
  Hight_Accuracy,

  /// 低功耗模式
  Battery_Saving,

  /// 仅设备(Gps)模式
  Device_Sensors
}

/// 场景定位枚举类
enum BDLocationPurpose {
  ///  签到场景
  /// 只进行一次定位返回最接近真实位置的定位结果（定位速度可能会延迟1-3s）
  SignIn,

  /// 出行场景
  /// 高精度连续定位，适用于有户内外切换的场景，卫星定位和网络定位相互切换，卫星定位成功之后网络定位不再返回，卫星信号断开之后一段时间才会返回网络结果
  Sport,

  /// 运动场景
  /// 高精度连续定位，适用于有户内外切换的场景，卫星定位和网络定位相互切换，卫星定位成功之后网络定位不再返回，卫星信号断开之后一段时间才会返回网络结果
  Transport
}

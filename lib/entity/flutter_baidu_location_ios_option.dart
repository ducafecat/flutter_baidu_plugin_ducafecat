/// 设置ios端定位参数类
class BaiduLocationIOSOption {
  /// 设置位置获取超时时间
  int locationTimeout;

  /// 设置获取地址信息超时时间
  int reGeocodeTimeout;

  /// 设置应用位置类型
  String activityType;

  /// 设置返回位置的坐标系类型
  String BMKLocationCoordinateType;

  /// 设置预期精度参数
  String desiredAccuracy;

  /// 是否需要最新版本rgc数据
  bool isNeedNewVersionRgc;

  /// 指定定位是否会被系统自动暂停
  bool pausesLocationUpdatesAutomatically;

  /// 指定是否允许后台定位
  bool allowsBackgroundLocationUpdates;

  /// 设定定位的最小更新距离
  double distanceFilter;

  /// 指定是否允许后台定位
  /// allowsBackgroundLocationUpdates为true则允许后台定位
  /// allowsBackgroundLocationUpdates为false则不允许后台定位
  void setAllowsBackgroundLocationUpdates(
      bool allowsBackgroundLocationUpdates) {
    this.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates;
  }

  /// 指定定位是否会被系统自动暂停
  /// pausesLocationUpdatesAutomatically为true则定位会被系统自动暂停
  /// pausesLocationUpdatesAutomatically为false则定位不会被系统自动暂停
  void setPauseLocUpdateAutomatically(bool pausesLocationUpdatesAutomatically) {
    this.pausesLocationUpdatesAutomatically =
        pausesLocationUpdatesAutomatically;
  }

  /// 设置位置获取超时时间
  void setLocationTimeout(int locationTimeout) {
    this.locationTimeout = locationTimeout;
  }

  /// 设置获取地址信息超时时间
  void setReGeocodeTimeout(int reGeocodeTimeout) {
    this.reGeocodeTimeout = reGeocodeTimeout;
  }

  /// 设置应用位置类型
  /// activityType可选值包括:
  /// "CLActivityTypeOther"
  /// "CLActivityTypeAutomotiveNavigation"
  /// "CLActivityTypeFitness"
  /// "CLActivityTypeOtherNavigation"
  void setActivityType(String activityType) {
    this.activityType = activityType;
  }

  /// 设置返回位置的坐标系类型
  /// BMKLocationCoordinateType可选值包括:
  /// "BMKLocationCoordinateTypeBMK09LL"
  /// "BMKLocationCoordinateTypeBMK09MC"
  /// "BMKLocationCoordinateTypeWGS84"
  /// "BMKLocationCoordinateTypeGCJ02"
  void setBMKLocationCoordinateType(String BMKLocationCoordinateType) {
    this.BMKLocationCoordinateType = BMKLocationCoordinateType;
  }

  /// 设置预期精度参数
  /// desiredAccuracy可选值包括:
  /// "kCLLocationAccuracyBest"
  /// "kCLLocationAccuracyNearestTenMeters"
  /// "kCLLocationAccuracyHundredMeters"
  /// "kCLLocationAccuracyKilometer"
  void setDesiredAccuracy(String desiredAccuracy) {
    this.desiredAccuracy = desiredAccuracy;
  }

  /// 设定定位的最小更新距离
  void setDistanceFilter(double distanceFilter) {
    this.distanceFilter = distanceFilter;
  }

  /// 是否需要最新版本rgc数据
  /// isNeedNewVersionRgc为true则需要返回最新版本rgc数据
  /// isNeedNewVersionRgc为false则不需要返回最新版本rgc数据
  void setIsNeedNewVersionRgc(bool isNeedNewVersionRgc) {
    this.isNeedNewVersionRgc = isNeedNewVersionRgc;
  }

  BaiduLocationIOSOption(
      {this.locationTimeout,
      this.reGeocodeTimeout,
      this.activityType,
      this.BMKLocationCoordinateType,
      this.desiredAccuracy,
      this.isNeedNewVersionRgc,
      this.pausesLocationUpdatesAutomatically,
      this.allowsBackgroundLocationUpdates,
      this.distanceFilter});

  /// 根据传入的map生成BaiduLocationIOSOption对象
  factory BaiduLocationIOSOption.fromMap(dynamic value) {
    return new BaiduLocationIOSOption(
      locationTimeout: value['locationTimeout'],
      reGeocodeTimeout: value['reGeocodeTimeout'],
      activityType: value['activityType'],
      BMKLocationCoordinateType: value['BMKLocationCoordinateType'],
      desiredAccuracy: value['desiredAccuracy'],
      isNeedNewVersionRgc: value['isNeedNewVersionRgc'],
      pausesLocationUpdatesAutomatically:
          value['pausesLocationUpdatesAutomatically'],
      allowsBackgroundLocationUpdates: value['allowsBackgroundLocationUpdates'],
      distanceFilter: value['distanceFilter'],
    );
  }

  /// 获取对本类所有变量赋值后的map键值对
  Map getMap() {
    return {
      "locationTimeout": locationTimeout,
      "reGeocodeTimeout": reGeocodeTimeout,
      "activityType": activityType,
      "BMKLocationCoordinateType": BMKLocationCoordinateType,
      "desiredAccuracy": desiredAccuracy,
      "isNeedNewVersionRgc": isNeedNewVersionRgc,
      "pausesLocationUpdatesAutomatically": pausesLocationUpdatesAutomatically,
      "allowsBackgroundLocationUpdates": allowsBackgroundLocationUpdates,
      "distanceFilter": distanceFilter,
    };
  }
}

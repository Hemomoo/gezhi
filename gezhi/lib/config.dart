import 'dart:io';

class Config {
  static const bool debug = false;

  static const String appName = '格志日记';

//正式的维修URL
  // static const fix_url = 'http://127.0.0.1:7100/';
//  维修的测试URL
  static const String gezhi_url = "http://127.0.0.1:7100/";
//
  static const String package = "com.yaobao.ad";
//  static const String version = "1.0.0";
  static final String platform = Platform.isIOS ? 'ios' : 'android';
  static final int requestDelayed = 300;
}

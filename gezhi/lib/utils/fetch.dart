import 'package:dio/dio.dart';
import 'package:gezhi/config.dart';

BaseOptions options = BaseOptions(
    baseUrl: Config.gezhi_url,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: 'application/x-www-form-urlencoded');

Future request(
  String url, {
  String method = 'POST',
}) async {
  try {
    Response response;

    // options.headers["token"]=406;

    Dio dio = new Dio();

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后台接口异常');
    }
  } catch (errow) {
    return print('接口错误$errow');
  }
}

import 'package:dio/dio.dart';
import '../helpers/api_constants.dart';

class DioFactory {
  static Dio getDio() {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.bearerToken}',
      },
    );

    return dio;
  }
}

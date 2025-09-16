import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

Dio _createDio(String baseUrl, {List<Interceptor>? additionalInterceptors}) {
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: const Duration(milliseconds: 10000),
    connectTimeout: const Duration(milliseconds: 10000),
    contentType: 'application/json; charset=utf-8',
    responseType: ResponseType.json,
  ));

  dio.interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      compact: false,
    ),
    ChuckerDioInterceptor(),
  ]);

  if (additionalInterceptors != null && additionalInterceptors.isNotEmpty) {
    dio.interceptors.addAll(additionalInterceptors);
  }

  return dio;
}

final appDio = _createDio(
  dotenv.env['API_BASE_URL'] ?? "");

final remoteDio = _createDio("");

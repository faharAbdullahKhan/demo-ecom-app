import 'package:demo_ecommerce/libraries/base/data/remote/api_response.dart';
import 'package:demo_ecommerce/libraries/base/data/remote/dio.dart';
import 'package:dio/dio.dart';

class _BaseApiService {
  final Dio _dio;

  _BaseApiService(this._dio);

  ApiResponse _getErrorResponse(DioException exception) {
    ApiResponse errorResponse;

    switch (exception.type) {
      case DioExceptionType.badResponse:
        {
          String errorMessage;
          try {
            String? error = exception.response?.data['error'];
            errorMessage = error ?? "Bad request error";
          } catch (e) {
            errorMessage = "Bad request error";
          }

          errorResponse = ApiResponse.apiError(errorMessage);

          final responseCode = exception.response?.statusCode;
          if (responseCode != null) {
            if (responseCode == ApiResponse.acceptanceErrorCode) {
              errorResponse = ApiResponse.acceptanceError(errorMessage);
            }
            if (responseCode == ApiResponse.forbiddenErrorCode) {
              errorResponse = ApiResponse.forbiddenError();
            }
          }

          if (exception.error != null &&
              exception.error == ApiResponse.tokenErrorCode) {
            errorResponse = ApiResponse.tokenError();
          }

          if (responseCode != null &&
              responseCode == ApiResponse.notFoundErrorCode) {
            errorResponse = ApiResponse.notFoundError(errorMessage);
          }
        }
      case DioExceptionType.connectionError:
        {
          errorResponse = ApiResponse.networkError();
        }
      case DioExceptionType.unknown:
        {
          errorResponse = ApiResponse.unknownError();
        }
      case DioExceptionType.sendTimeout:
        {
          errorResponse = ApiResponse.timeOutError();
        }
      case DioExceptionType.receiveTimeout:
        {
          errorResponse = ApiResponse.timeOutError();
        }
      default:
        {
          errorResponse = ApiResponse.unknownError();
        }
    }
    return errorResponse;
  }

  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(path,
          data: data, queryParameters: queryParameters, options: options);
      return ApiResponse.successResponse(response.data);
    } on DioException catch (e) {
      return _getErrorResponse(e);
    } catch (e) {
      return ApiResponse.unknownError();
    }
  }

  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(path,
          options: options, queryParameters: queryParameters);
      return ApiResponse.successResponse(response.data);
    } on DioException catch (e) {
      return _getErrorResponse(e);
    } catch (e) {
      return ApiResponse.unknownError();
    }
  }

  Future<ApiResponse> put<T>(
    String path, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(path,
          data: data, queryParameters: queryParameters, options: options);
      return ApiResponse.successResponse(response.data);
    } on DioException catch (e) {
      return _getErrorResponse(e);
    } catch (e) {
      return ApiResponse.unknownError();
    }
  }

  Future<ApiResponse> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(path,
          data: data, queryParameters: queryParameters, options: options);
      return ApiResponse.successResponse(response.data);
    } on DioException catch (e) {
      return _getErrorResponse(e);
    } catch (e) {
      return ApiResponse.unknownError();
    }
  }

  Future<ApiResponse> fetch(
    RequestOptions options
  ) async {
    try {
      final response = await _dio.fetch(options);
      return ApiResponse.successResponse(response.data);
    } on DioException catch (e) {
      return _getErrorResponse(e);
    } catch (e) {
      return ApiResponse.unknownError();
    }
  }
}

class AppApiService extends _BaseApiService {
  AppApiService() : super(appDio);
}

class RemoteApiService extends _BaseApiService {
  RemoteApiService()  : super(remoteDio);
}

Map<String, dynamic> getAuthHeader(String? token) =>
    {'Authorization': 'Bearer $token'};

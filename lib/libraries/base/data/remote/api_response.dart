final class ApiResponse {
  static const networkErrorCode = 1000;
  static const apiErrorCode = 1001;
  static const unknownErrorCode = 1002;
  static const timeOutErrorCode = 1004;
  static const tokenErrorCode = 401;
  static const forbiddenErrorCode = 403;
  static const notFoundErrorCode = 404;
  static const acceptanceErrorCode = 451;

  final dynamic data;
  final int? errorCode;
  final String? error;
  final bool hasError;

  ApiResponse(
      {required this.data,
      required this.errorCode,
      required this.error,
      required this.hasError});

  static ApiResponse networkError() => ApiResponse(
      data: null,
      errorCode: networkErrorCode,
      error: "Network connection error",
      hasError: true);

  static ApiResponse apiError(String error) => ApiResponse(
      data: null, errorCode: apiErrorCode, error: error, hasError: true);

  static ApiResponse acceptanceError(String error) => ApiResponse(
      data: null, errorCode: acceptanceErrorCode, error: error, hasError: true);

  static ApiResponse unknownError() => ApiResponse(
      data: null,
      errorCode: unknownErrorCode,
      error: "Unknown error",
      hasError: true);

  static ApiResponse tokenError() => ApiResponse(
      data: null,
      errorCode: tokenErrorCode,
      error: "Refresh token error",
      hasError: true);

  static ApiResponse forbiddenError() => ApiResponse(
      data: null,
      errorCode: forbiddenErrorCode,
      error: "Account disabled",
      hasError: true);

  static ApiResponse timeOutError() => ApiResponse(
      data: null,
      errorCode: timeOutErrorCode,
      error: "Timeout error",
      hasError: true);

  static ApiResponse successResponse(dynamic data) =>
      ApiResponse(data: data, errorCode: null, error: null, hasError: false);

  static ApiResponse notFoundError(String error) => ApiResponse(
      data: null, errorCode: notFoundErrorCode, error: error, hasError: true);
}

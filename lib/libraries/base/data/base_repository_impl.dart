
import 'package:demo_ecommerce/libraries/base/data/remote/api_response.dart';
import 'package:demo_ecommerce/libraries/base/domain/failure.dart';

class BaseRepositoryImpl {
  Failure getFailureFromErrorReponse(ApiResponse response) {
    Failure failure = UnknownFailure();

    if (response.hasError) {
      switch (response.errorCode) {
        case ApiResponse.apiErrorCode:
          failure = RequestFailure(response.error!);

        case ApiResponse.networkErrorCode:
          failure = ConnectionFailure();

        case ApiResponse.tokenErrorCode:
          {
            failure = TokenFailure();
          }
        case ApiResponse.acceptanceErrorCode:
          failure = AcceptanceFailure();

        case ApiResponse.notFoundErrorCode:
          failure = NotFoundFailure(response.error!);

        case ApiResponse.forbiddenErrorCode:
          failure = AccountDisabledFailure();

        default:
          failure = UnknownFailure();
      }
    }

    return failure;
  }
}

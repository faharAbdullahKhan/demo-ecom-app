import 'package:flutter/material.dart';

@immutable
sealed class Failure {}

final class UnknownFailure extends Failure {}

final class ConnectionFailure extends Failure {}

final class RequestFailure extends Failure {
  final String error;

  RequestFailure(this.error);
}

final class TokenFailure extends Failure {}

final class AccountDisabledFailure extends Failure {}

final class AcceptanceFailure extends Failure {}

final class NotFoundFailure extends Failure {
  final String error;

  NotFoundFailure(this.error);
}

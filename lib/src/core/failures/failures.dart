import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class ServerFailure extends Failure {
  const ServerFailure();

  @override
  List<Object> get props => <Object>[];
}

class CacheFailure extends Failure {
  const CacheFailure();

  @override
  List<Object> get props => <Object>[];
}

/// A request the server understood and turned down. [code] is stable and
/// the presentation layer maps it to a localized message.
class ValidationFailure extends Failure {
  const ValidationFailure(this.code);

  final String code;

  @override
  List<Object> get props => <Object>[code];
}

/// The stable codes a [ValidationFailure] carries.
abstract final class FailureCodes {
  static const String invalidCredentials = 'invalid_credentials';
  static const String emailTaken = 'email_taken';
  static const String invalidPromo = 'invalid_promo';
  static const String promoMinimum = 'promo_minimum';
  static const String notCancellable = 'not_cancellable';
  static const String emptyCart = 'empty_cart';
}

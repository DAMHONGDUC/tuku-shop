import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// A usecase that is a live view rather than a request: the cart, the
/// wishlist, the signed-in user.
abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => <Object>[];
}

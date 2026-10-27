import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/failures/config_failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

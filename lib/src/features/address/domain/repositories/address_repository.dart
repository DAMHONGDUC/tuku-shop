import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/entities/address_entity.dart';

abstract class AddressRepository {
  /// Default address first.
  Future<Either<Failure, List<AddressEntity>>> getAddresses();

  /// Adds (empty id) or updates; returns the saved address.
  Future<Either<Failure, AddressEntity>> save(AddressEntity address);

  Future<Either<Failure, Unit>> delete(String id);

  Future<Either<Failure, Unit>> setDefault(String id);

  Future<Either<Failure, Unit>> reset();
}

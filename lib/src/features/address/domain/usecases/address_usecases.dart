import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/entities/address_entity.dart';
import 'package:tuku_shop/src/features/address/domain/repositories/address_repository.dart';

class GetAddressesUsecase implements UseCase<List<AddressEntity>, NoParams> {
  final AddressRepository repository;

  GetAddressesUsecase(this.repository);

  @override
  Future<Either<Failure, List<AddressEntity>>> call(NoParams params) =>
      repository.getAddresses();
}

enum AddressField { fullName, phone, street, city, state, postalCode }

/// Checks required fields before saving; returns the fields that are wrong.
class SaveAddressUsecase implements UseCase<AddressEntity, AddressEntity> {
  final AddressRepository repository;

  SaveAddressUsecase(this.repository);

  static final _phone = RegExp(r'^\+?[0-9 ()-]{7,}$');
  static final _postal = RegExp(r'^[A-Za-z0-9 -]{3,10}$');

  static Set<AddressField> validate(AddressEntity a) => {
    if (a.fullName.trim().length < 2) AddressField.fullName,
    if (!_phone.hasMatch(a.phone.trim())) AddressField.phone,
    if (a.street.trim().length < 4) AddressField.street,
    if (a.city.trim().isEmpty) AddressField.city,
    if (a.state.trim().isEmpty) AddressField.state,
    if (!_postal.hasMatch(a.postalCode.trim())) AddressField.postalCode,
  };

  @override
  Future<Either<Failure, AddressEntity>> call(AddressEntity params) {
    final errors = validate(params);
    if (errors.isNotEmpty) {
      return Future.value(Left(ValidationFailure(errors.first.name)));
    }
    return repository.save(params);
  }
}

class DeleteAddressUsecase implements UseCase<Unit, String> {
  final AddressRepository repository;

  DeleteAddressUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String params) =>
      repository.delete(params);
}

class SetDefaultAddressUsecase implements UseCase<Unit, String> {
  final AddressRepository repository;

  SetDefaultAddressUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String params) =>
      repository.setDefault(params);
}

class ResetAddressesUsecase implements UseCase<Unit, NoParams> {
  final AddressRepository repository;

  ResetAddressesUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => repository.reset();
}

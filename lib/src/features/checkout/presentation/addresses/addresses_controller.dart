import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

part 'addresses_state.dart';

class AddressesController extends Cubit<AddressesState> {
  AddressesController({
    required this._getAddresses,
    required this._saveAddress,
    required this._deleteAddress,
  }) : super(const AddressesState());

  final GetAddressesUsecase _getAddresses;
  final SaveAddressUsecase _saveAddress;
  final DeleteAddressUsecase _deleteAddress;

  Future<void> load() async {
    final Either<Failure, List<AddressEntity>> result = await _getAddresses(
      const NoParams(),
    );
    result.fold(
      (Failure _) => emit(const AddressesState(status: LoadStatus.failure)),
      (List<AddressEntity> a) =>
          emit(AddressesState(status: LoadStatus.success, addresses: a)),
    );
  }

  Future<void> makeDefault(AddressEntity address) async {
    await _saveAddress(address.copyWith(isDefault: true));
    await load();
  }

  Future<void> delete(String id) async {
    emit(
      AddressesState(
        status: state.status,
        addresses: state.addresses
            .where((AddressEntity a) => a.id != id)
            .toList(),
      ),
    );
    await _deleteAddress(id);
    await load();
  }
}

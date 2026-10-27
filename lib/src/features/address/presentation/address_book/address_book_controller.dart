import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';

part 'address_book_state.dart';

class AddressBookController extends Cubit<AddressBookState> {
  AddressBookController(
    this._getAddressesUsecase,
    this._setDefaultUsecase,
    this._deleteUsecase,
  ) : super(const AddressBookState());

  final GetAddressesUsecase _getAddressesUsecase;
  final SetDefaultAddressUsecase _setDefaultUsecase;
  final DeleteAddressUsecase _deleteUsecase;

  Future<void> load({bool silent = false}) async {
    if (!silent) emit(const AddressBookState());
    final result = await _getAddressesUsecase.call(NoParams());
    result.fold(
      (_) => emit(const AddressBookState(status: AddressBookStatus.error)),
      (list) => emit(
        AddressBookState(status: AddressBookStatus.loaded, addresses: list),
      ),
    );
  }

  Future<void> setDefault(String id) async {
    emit(
      AddressBookState(
        status: AddressBookStatus.loaded,
        addresses: [
          for (final a in state.addresses) a.copyWith(isDefault: a.id == id),
        ]..sort((a, b) => a.isDefault ? -1 : (b.isDefault ? 1 : 0)),
      ),
    );
    await _setDefaultUsecase.call(id);
  }

  Future<void> delete(String id) async {
    emit(
      AddressBookState(
        status: AddressBookStatus.loaded,
        addresses: state.addresses.where((a) => a.id != id).toList(),
      ),
    );
    await _deleteUsecase.call(id);
    await load(silent: true);
  }
}

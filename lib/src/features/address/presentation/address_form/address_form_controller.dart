import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';

part 'address_form_state.dart';

class AddressFormController extends Cubit<AddressFormState> {
  AddressFormController(this._saveAddressUsecase)
    : super(const AddressFormState());

  final SaveAddressUsecase _saveAddressUsecase;

  Future<void> save(AddressEntity address) async {
    final errors = SaveAddressUsecase.validate(address);
    if (errors.isNotEmpty) {
      emit(AddressFormState(errors: errors));
      return;
    }
    emit(const AddressFormState(isSaving: true));
    final result = await _saveAddressUsecase.call(address);
    result.fold(
      (_) => emit(const AddressFormState(saveFailed: true)),
      (saved) => emit(AddressFormState(saved: saved)),
    );
  }
}

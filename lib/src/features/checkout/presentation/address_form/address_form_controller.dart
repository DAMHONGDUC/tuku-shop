import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

part 'address_form_state.dart';

class AddressFormController extends Cubit<AddressFormState> {
  AddressFormController({
    required GetAddressesUsecase getAddresses,
    required SaveAddressUsecase saveAddress,
  }) : _getAddresses = getAddresses,
       _saveAddress = saveAddress,
       super(const AddressFormState());

  final GetAddressesUsecase _getAddresses;
  final SaveAddressUsecase _saveAddress;

  Future<void> load(String? id) async {
    if (id == null) {
      emit(const AddressFormState(ready: true));
      return;
    }

    final Either<Failure, List<AddressEntity>> result = await _getAddresses(
      const NoParams(),
    );
    emit(
      AddressFormState(
        ready: true,
        existing: result
            .getOrElse(() => const <AddressEntity>[])
            .firstWhereOrNull((AddressEntity a) => a.id == id),
      ),
    );
  }

  /// Field names left empty; nothing is saved while any are.
  Future<void> save(AddressEntity draft) async {
    final Set<String> missing = <String>{
      if (draft.fullName.trim().isEmpty) 'name',
      if (draft.phone.trim().isEmpty) 'phone',
      if (draft.street.trim().isEmpty) 'street',
      if (draft.city.trim().isEmpty) 'city',
      if (draft.postalCode.trim().isEmpty) 'postal',
    };

    emit(state.copyWith(missing: missing));

    if (missing.isNotEmpty) return;

    emit(state.copyWith(saving: true));

    final Either<Failure, AddressEntity> result = await _saveAddress(draft);

    result.fold(
      (Failure _) => emit(state.copyWith(saving: false)),
      (AddressEntity saved) => emit(state.copyWith(saving: false, savedId: saved.id)),
    );
  }
}

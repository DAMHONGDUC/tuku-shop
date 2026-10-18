part of 'address_form_controller.dart';

class AddressFormState extends Equatable {
  final Set<AddressField> errors;
  final bool isSaving;
  final AddressEntity? saved;
  final bool saveFailed;

  const AddressFormState({
    this.errors = const {},
    this.isSaving = false,
    this.saved,
    this.saveFailed = false,
  });

  @override
  List<Object?> get props => [errors, isSaving, saved, saveFailed];
}

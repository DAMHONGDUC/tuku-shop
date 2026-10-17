part of 'address_form_controller.dart';

class AddressFormState extends Equatable {
  const AddressFormState({
    this.ready = false,
    this.existing,
    this.missing = const <String>{},
    this.saving = false,
    this.savedId,
  });

  final bool ready;
  final AddressEntity? existing;
  final Set<String> missing;
  final bool saving;
  final String? savedId;

  AddressFormState copyWith({
    Set<String>? missing,
    bool? saving,
    String? savedId,
  }) => AddressFormState(
    ready: ready,
    existing: existing,
    missing: missing ?? this.missing,
    saving: saving ?? this.saving,
    savedId: savedId ?? this.savedId,
  );

  @override
  List<Object?> get props => <Object?>[
    ready,
    existing,
    missing,
    saving,
    savedId,
  ];
}

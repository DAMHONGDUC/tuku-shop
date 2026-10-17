part of 'addresses_controller.dart';

class AddressesState extends Equatable {
  const AddressesState({
    this.status = LoadStatus.loading,
    this.addresses = const <AddressEntity>[],
  });

  final LoadStatus status;
  final List<AddressEntity> addresses;

  @override
  List<Object> get props => <Object>[status, addresses];
}

part of 'address_book_controller.dart';

enum AddressBookStatus { loading, loaded, error }

class AddressBookState extends Equatable {
  final AddressBookStatus status;
  final List<AddressEntity> addresses;

  const AddressBookState({
    this.status = AddressBookStatus.loading,
    this.addresses = const [],
  });

  @override
  List<Object?> get props => [status, addresses];
}

import 'package:system_design/index.dart';

/// The address book, pushed above the tabs.
class AddressRoutes {
  static const SdRouterV5 addresses = SdRouterV5(
    name: 'addresses',
    path: '/addresses',
    fullPath: '/addresses',
  );

  static const SdRouterV5 addressForm = SdRouterV5(
    name: 'address-form',
    path: 'form',
    fullPath: '/addresses/form',
  );

  /// The address book in pick mode: pops with the chosen address id.
  static String pickLocation({String? selectedId}) => Uri(
    path: addresses.fullPath,
    queryParameters: {'pick': '1', 'selected': ?selectedId},
  ).toString();
}

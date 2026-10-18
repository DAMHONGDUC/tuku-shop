import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/address/presentation/address_form/address_form_screen.dart';

import '../address_book_screen.dart';

class AddressStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: AddressRoutes.addresses.path,
      name: AddressRoutes.addresses.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        final query = state.uri.queryParameters;
        return AddressBookScreen(
          pickMode: query['pick'] == '1',
          selectedId: query['selected'],
        );
      },
      routes: [
        SdGoRouteV5(
          path: AddressRoutes.addressForm.path,
          name: AddressRoutes.addressForm.name,
          parentNavigatorKey: kRootNavigatorKey,
          builder: (BuildContext context, GoRouterState state) {
            return AddressFormScreen(address: state.extra as AddressEntity?);
          },
        ),
      ],
    ),
  ];
}

import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:tuku_shop/src/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

import 'presentation/address_form/address_form_controller.dart';
import 'presentation/addresses/addresses_controller.dart';
import 'presentation/checkout/checkout_controller.dart';
import 'presentation/order_success/order_success_controller.dart';
import 'presentation/payment_methods/payment_methods_controller.dart';

class CheckoutDi {
  static void config() {
    getIt.registerLazySingleton<CheckoutRemoteDataSource>(
      CheckoutRemoteDataSourceImpl.new,
    );
    getIt.registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(dataSource: getIt()),
    );

    getIt.registerLazySingleton<GetAddressesUsecase>(
      () => GetAddressesUsecase(getIt()),
    );
    getIt.registerLazySingleton<SaveAddressUsecase>(
      () => SaveAddressUsecase(getIt()),
    );
    getIt.registerLazySingleton<DeleteAddressUsecase>(
      () => DeleteAddressUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetPaymentMethodsUsecase>(
      () => GetPaymentMethodsUsecase(getIt()),
    );
    getIt.registerLazySingleton<SetDefaultPaymentMethodUsecase>(
      () => SetDefaultPaymentMethodUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetDeliveryOptionsUsecase>(
      () => GetDeliveryOptionsUsecase(getIt()),
    );

    getIt.registerFactory<CheckoutController>(
      () => CheckoutController(
        getAddresses: getIt(),
        getPaymentMethods: getIt(),
        getDeliveryOptions: getIt(),
        placeOrder: getIt(),
        clearCart: getIt(),
      ),
    );
    getIt.registerFactory<OrderSuccessController>(
      () => OrderSuccessController(getIt()),
    );
    getIt.registerFactory<AddressesController>(
      () => AddressesController(
        getAddresses: getIt(),
        saveAddress: getIt(),
        deleteAddress: getIt(),
      ),
    );
    getIt.registerFactory<AddressFormController>(
      () => AddressFormController(getAddresses: getIt(), saveAddress: getIt()),
    );
    getIt.registerFactory<PaymentMethodsController>(
      () => PaymentMethodsController(
        getPaymentMethods: getIt(),
        setDefault: getIt(),
      ),
    );
  }
}

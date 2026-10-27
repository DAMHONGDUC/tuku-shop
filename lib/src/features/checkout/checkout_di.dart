import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:tuku_shop/src/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/presentation/checkout/checkout_controller.dart';
import 'package:tuku_shop/src/features/checkout/presentation/order_success/order_success_controller.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

class CheckoutDi {
  static config() {
    getIt.registerLazySingleton<CheckoutRemoteDataSource>(
      () => const CheckoutRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<CheckoutRepository>(
      () =>
          CheckoutRepositoryImpl(dataSource: getIt<CheckoutRemoteDataSource>()),
    );
    getIt.registerLazySingleton<GetShippingMethodsUsecase>(
      () => GetShippingMethodsUsecase(getIt<CheckoutRepository>()),
    );
    getIt.registerLazySingleton<GetPaymentMethodsUsecase>(
      () => GetPaymentMethodsUsecase(getIt<CheckoutRepository>()),
    );
    getIt.registerLazySingleton<ApplyVoucherUsecase>(
      () => ApplyVoucherUsecase(getIt<CheckoutRepository>()),
    );
    getIt.registerFactory<CheckoutController>(
      () => CheckoutController(
        getCart: getIt<GetCartUsecase>(),
        getAddresses: getIt<GetAddressesUsecase>(),
        getShippingMethods: getIt<GetShippingMethodsUsecase>(),
        getPaymentMethods: getIt<GetPaymentMethodsUsecase>(),
        applyVoucher: getIt<ApplyVoucherUsecase>(),
        placeOrder: getIt<PlaceOrderUsecase>(),
        removeCartLines: getIt<RemoveCartLinesUsecase>(),
        addNotification: getIt<AddNotificationUsecase>(),
      ),
    );
    getIt.registerFactory<OrderSuccessController>(
      () => OrderSuccessController(getIt<GetOrderDetailUsecase>()),
    );
  }
}

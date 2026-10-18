import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_local_data_source.dart';
import 'package:tuku_shop/src/features/order/data/repositories/order_repository_impl.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/order/presentation/my_orders/orders_list_controller.dart';
import 'package:tuku_shop/src/features/order/presentation/order_detail/order_detail_controller.dart';

class OrderDi {
  static config() {
    getIt.registerLazySingleton<OrderLocalDataSource>(
      () => OrderLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(dataSource: getIt<OrderLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetOrdersUsecase>(
      () => GetOrdersUsecase(getIt<OrderRepository>()),
    );
    getIt.registerLazySingleton<GetOrderDetailUsecase>(
      () => GetOrderDetailUsecase(getIt<OrderRepository>()),
    );
    getIt.registerLazySingleton<GetOrderCountsUsecase>(
      () => GetOrderCountsUsecase(getIt<OrderRepository>()),
    );
    getIt.registerLazySingleton<PlaceOrderUsecase>(
      () => PlaceOrderUsecase(getIt<OrderRepository>()),
    );
    getIt.registerLazySingleton<CancelOrderUsecase>(
      () => CancelOrderUsecase(getIt<OrderRepository>()),
    );
    getIt.registerLazySingleton<WatchOrderChangesUsecase>(
      () => WatchOrderChangesUsecase(getIt<OrderRepository>()),
    );
    getIt.registerLazySingleton<ResetOrdersUsecase>(
      () => ResetOrdersUsecase(getIt<OrderRepository>()),
    );
    getIt.registerFactory<OrdersListController>(
      () => OrdersListController(
        getIt<GetOrdersUsecase>(),
        getIt<WatchOrderChangesUsecase>(),
      ),
    );
    getIt.registerFactory<OrderDetailController>(
      () => OrderDetailController(
        getIt<GetOrderDetailUsecase>(),
        getIt<CancelOrderUsecase>(),
        getIt<AddToCartUsecase>(),
        getIt<AddNotificationUsecase>(),
      ),
    );
  }
}

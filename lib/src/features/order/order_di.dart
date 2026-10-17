import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:tuku_shop/src/features/order/data/repositories/order_repository_impl.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import 'presentation/order_detail/order_detail_controller.dart';
import 'presentation/orders/orders_controller.dart';

class OrderDi {
  static void config() {
    getIt.registerLazySingleton<OrderRemoteDataSource>(
      OrderRemoteDataSourceImpl.new,
    );
    getIt.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(dataSource: getIt()),
    );

    getIt.registerLazySingleton<GetOrdersUsecase>(
      () => GetOrdersUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetOrderDetailUsecase>(
      () => GetOrderDetailUsecase(getIt()),
    );
    getIt.registerLazySingleton<PlaceOrderUsecase>(
      () => PlaceOrderUsecase(getIt()),
    );
    getIt.registerLazySingleton<CancelOrderUsecase>(
      () => CancelOrderUsecase(getIt()),
    );

    getIt.registerFactory<OrdersController>(() => OrdersController(getIt()));
    getIt.registerFactory<OrderDetailController>(
      () => OrderDetailController(
        getOrder: getIt(),
        cancelOrder: getIt(),
        addToCart: getIt(),
      ),
    );
  }
}

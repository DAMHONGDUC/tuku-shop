import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/mock/order_mock.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';
import 'package:tuku_shop/src/features/order/data/models/orders_data_model.dart';
import 'package:tuku_shop/src/features/order/domain/entities/get_my_order_filter_params.dart';
import 'package:system_design/index.dart';

abstract class OrderRemoteDataSource {
  Future<OrdersDataModel> getMyOrder({required GetMyOrderFilterParams params});

  Future<OrderModel?> getOrderDetail({required String orderId});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl();

  // Singleton-like static cache — resets when the app restarts
  static final Map<OrderStatus, List<OrderModel>> _cachedOrders = {};

  // Config: fixed number of mock records per status
  static const _mockCountPerStatus = {
    OrderStatus.waitingForConfirmation: 20,
    OrderStatus.waitingForPickup: 0,
    OrderStatus.waitingForDelivery: 7,
    OrderStatus.delivered: 32,
    OrderStatus.rolledBack: 5,
    OrderStatus.cancelled: 12,
  };

  @override
  Future<OrdersDataModel> getMyOrder({
    required GetMyOrderFilterParams params,
  }) async {
    try {
      await SdHelperV5.delayLoading();

      _initializeMockDataIfNeeded();

      final allOrders = _cachedOrders[params.status] ?? [];

      final startIndex = (params.pageNumber - 1) * params.itemCount;
      final endIndex = startIndex + params.itemCount;
      final paginatedItems = (startIndex < allOrders.length)
          ? allOrders.sublist(startIndex, endIndex.clamp(0, allOrders.length))
          : <OrderModel>[];

      final totalRecords = allOrders.length;
      final totalPage = (totalRecords / params.itemCount).ceil();

      return OrdersDataModel(
        items: paginatedItems,
        totalPage: totalPage,
        currentPage: params.pageNumber,
        totalRecord: totalRecords,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<OrderModel?> getOrderDetail({required String orderId}) async {
    try {
      await SdHelperV5.delayLoading();

      _initializeMockDataIfNeeded();

      return _cachedOrders.values
          .expand((orders) => orders)
          .firstWhereOrNull((e) => e.id == orderId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // Initialize once per app run
  void _initializeMockDataIfNeeded() {
    if (_cachedOrders.isNotEmpty) return;

    for (final entry in _mockCountPerStatus.entries) {
      final status = entry.key;
      final count = entry.value;

      _cachedOrders[status] = OrderMock.generateOrders(
        count: count,
      ).map((e) => e.copyWith(status: status)).toList();
    }
  }

  // Optional: to clear mock cache manually (e.g., for testing)
  static void clearMockCache() => _cachedOrders.clear();
}

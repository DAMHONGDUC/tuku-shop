import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

/// The just-placed order, for the success screen's summary card. Null
/// while loading.
class OrderSuccessController extends Cubit<OrderEntity?> {
  OrderSuccessController(this._getOrderDetailUsecase) : super(null);

  final GetOrderDetailUsecase _getOrderDetailUsecase;

  Future<void> load(String orderId) async {
    final result = await _getOrderDetailUsecase.call(orderId);
    result.fold((_) {}, emit);
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

part 'product_seller_state.dart';

/// The shop card on the product page; its own request, so the page never
/// waits for it.
class ProductSellerController extends Cubit<ProductSellerState> {
  ProductSellerController(this._getSellerUsecase)
    : super(const ProductSellerState());

  final GetSellerUsecase _getSellerUsecase;

  Future<void> load(String sellerId) async {
    emit(const ProductSellerState());
    final result = await _getSellerUsecase.call(sellerId);
    if (isClosed) return;
    result.fold(
      (_) => emit(const ProductSellerState(status: ProductSellerStatus.error)),
      (seller) => emit(
        ProductSellerState(status: ProductSellerStatus.loaded, seller: seller),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

part 'shop_header_state.dart';

/// The shop page header: the shop, how many listings it has, and Follow.
/// The shop and its count load side by side.
class ShopHeaderController extends Cubit<ShopHeaderState> {
  ShopHeaderController(this._getSeller, this._getProducts, this._toggleFollow)
    : super(const ShopHeaderState());

  final GetSellerUsecase _getSeller;
  final GetProductsUsecase _getProducts;
  final ToggleFollowSellerUsecase _toggleFollow;

  Future<void> load(String sellerId) async {
    emit(const ShopHeaderState());
    final sellerRequest = _getSeller.call(sellerId);
    // One item is enough: the page reports the shop's total.
    final countRequest = _getProducts.call(
      ProductQuery(sellerId: sellerId, pageSize: 1),
    );
    final seller = await sellerRequest;
    final count = await countRequest;
    if (isClosed) return;
    seller.fold(
      (_) => emit(const ShopHeaderState(status: ShopHeaderStatus.error)),
      (s) => emit(
        ShopHeaderState(
          status: ShopHeaderStatus.loaded,
          seller: s,
          productCount: count.fold((_) => null, (page) => page.totalRecord),
        ),
      ),
    );
  }

  Future<void> toggleFollow() async {
    final seller = state.seller;
    if (seller == null || state.isTogglingFollow) return;
    emit(state.copyWith(isTogglingFollow: true));
    final result = await _toggleFollow.call(seller.id);
    if (isClosed) return;
    result.fold(
      (_) => emit(
        state.copyWith(
          isTogglingFollow: false,
          failureCount: state.failureCount + 1,
        ),
      ),
      (updated) =>
          emit(state.copyWith(seller: updated, isTogglingFollow: false)),
    );
  }
}

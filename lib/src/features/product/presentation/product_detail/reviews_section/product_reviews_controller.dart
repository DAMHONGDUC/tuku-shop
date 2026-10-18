import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_reviews_state.dart';

/// Reviews load on their own request, after the product header is already
/// on screen, five at a time.
class ProductReviewsController extends Cubit<ProductReviewsState> {
  ProductReviewsController(this._getProductReviewsUsecase)
    : super(const ProductReviewsState());

  final GetProductReviewsUsecase _getProductReviewsUsecase;
  late String _productId;

  static const pageSize = 5;

  Future<void> load(String productId) async {
    _productId = productId;
    emit(const ProductReviewsState());
    final result = await _getProductReviewsUsecase.call(
      ProductReviewsParams(productId: productId, pageSize: pageSize),
    );
    result.fold(
      (_) => emit(state.copyWith(status: ProductReviewsStatus.error)),
      (page) => emit(
        ProductReviewsState(
          status: ProductReviewsStatus.loaded,
          items: page.items,
          page: page.currentPage,
          totalRecord: page.totalRecord,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getProductReviewsUsecase.call(
      ProductReviewsParams(
        productId: _productId,
        page: state.page + 1,
        pageSize: pageSize,
      ),
    );
    result.fold(
      (_) => emit(state.copyWith(isLoadingMore: false)),
      (page) => emit(
        state.copyWith(
          items: [...state.items, ...page.items],
          page: page.currentPage,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }
}

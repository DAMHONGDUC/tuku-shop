import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_reviews_state.dart';

/// Reviews load on their own request, after the product header is already
/// on screen: a short preview on the product page, pages of [pageSize] on
/// the All reviews screen.
class ProductReviewsController extends Cubit<ProductReviewsState> {
  ProductReviewsController(this._getProductReviewsUsecase)
    : super(const ProductReviewsState());

  final GetProductReviewsUsecase _getProductReviewsUsecase;
  late String _productId;
  int _pageSize = pageSize;

  static const pageSize = 10;

  /// How many reviews the product page previews before "View all".
  static const previewSize = 3;

  Future<void> load(String productId, {int pageSize = pageSize}) async {
    _productId = productId;
    _pageSize = pageSize;
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
        pageSize: _pageSize,
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

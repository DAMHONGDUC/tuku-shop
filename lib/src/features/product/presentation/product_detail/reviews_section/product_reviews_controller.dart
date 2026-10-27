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

  Future<void> load(String productId, {int pageSize = pageSize}) {
    _productId = productId;
    _pageSize = pageSize;
    return _loadFirstPage();
  }

  /// Narrows to this color, or clears it when it is already chosen; the
  /// size filter stays.
  Future<void> toggleColor(String colorName) {
    emit(
      ProductReviewsState(
        colorFilter: colorName == state.colorFilter ? null : colorName,
        sizeFilter: state.sizeFilter,
      ),
    );
    return _loadFirstPage();
  }

  /// Narrows to this size (or model), or clears it; the color filter stays.
  Future<void> toggleSize(String size) {
    emit(
      ProductReviewsState(
        colorFilter: state.colorFilter,
        sizeFilter: size == state.sizeFilter ? null : size,
      ),
    );
    return _loadFirstPage();
  }

  /// Back to every review.
  Future<void> clearFilter() {
    emit(const ProductReviewsState());
    return _loadFirstPage();
  }

  Future<void> _loadFirstPage() async {
    final colorFilter = state.colorFilter;
    final sizeFilter = state.sizeFilter;
    emit(ProductReviewsState(colorFilter: colorFilter, sizeFilter: sizeFilter));
    final result = await _getProductReviewsUsecase.call(
      ProductReviewsParams(
        productId: _productId,
        pageSize: _pageSize,
        colorName: colorFilter,
        size: sizeFilter,
      ),
    );
    if (isClosed ||
        colorFilter != state.colorFilter ||
        sizeFilter != state.sizeFilter) {
      return;
    }
    result.fold(
      (_) => emit(state.copyWith(status: ProductReviewsStatus.error)),
      (page) => emit(
        ProductReviewsState(
          status: ProductReviewsStatus.loaded,
          items: page.items,
          page: page.currentPage,
          totalRecord: page.totalRecord,
          hasMore: page.hasMore,
          colorFilter: colorFilter,
          sizeFilter: sizeFilter,
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
        colorName: state.colorFilter,
        size: state.sizeFilter,
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

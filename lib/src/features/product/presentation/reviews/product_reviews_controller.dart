import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_reviews_state.dart';

class ProductReviewsController extends Cubit<ProductReviewsState> {
  ProductReviewsController(this._getReviews)
    : super(const ProductReviewsState());

  final GetProductReviewsUsecase _getReviews;
  late String _productId;

  Future<void> load(String productId) async {
    _productId = productId;
    emit(const ProductReviewsState());
    await _fetch(1);
  }

  Future<void> loadMore() async {
    if (state.status != LoadStatus.success ||
        !state.hasMore ||
        state.loadingMore) {
      return;
    }

    emit(state.copyWith(loadingMore: true));
    await _fetch(state.page + 1);
  }

  void setStarFilter(int? stars) =>
      emit(state.copyWith(starFilter: () => stars));

  Future<void> _fetch(int page) async {
    final Either<Failure, ReviewsPage> result = await _getReviews(
      ReviewsParams(productId: _productId, page: page),
    );

    result.fold(
      (Failure _) => emit(
        page == 1
            ? const ProductReviewsState(status: LoadStatus.failure)
            : state.copyWith(loadingMore: false),
      ),
      (ReviewsPage data) => emit(
        state.copyWith(
          status: LoadStatus.success,
          summary: data.summary,
          items: <ReviewEntity>[if (page > 1) ...state.items, ...data.items],
          page: data.page,
          hasMore: data.hasMore,
          loadingMore: false,
        ),
      ),
    );
  }
}

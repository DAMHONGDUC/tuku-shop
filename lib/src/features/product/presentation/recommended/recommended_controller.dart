import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'recommended_state.dart';

/// "Picked for you" at the foot of home: the recommended sort, paged in as
/// the user scrolls.
class RecommendedController extends Cubit<RecommendedState> {
  RecommendedController(this._getProducts) : super(const RecommendedState());

  final GetProductsUsecase _getProducts;

  Future<void> load() async {
    emit(const RecommendedState());
    await _fetch(1);
  }

  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.loadingMore ||
        state.status != LoadStatus.success) {
      return;
    }

    emit(state.copyWith(loadingMore: true));
    await _fetch(state.page + 1);
  }

  Future<void> _fetch(int page) async {
    final Either<Failure, ProductPage> result = await _getProducts(
      ProductQuery(page: page),
    );

    result.fold(
      (Failure _) => emit(
        page == 1
            ? const RecommendedState(status: LoadStatus.failure)
            : state.copyWith(loadingMore: false),
      ),
      (ProductPage data) => emit(
        RecommendedState(
          status: LoadStatus.success,
          products: <ProductEntity>[
            if (page > 1) ...state.products,
            ...data.items,
          ],
          page: data.page,
          hasMore: data.hasMore,
        ),
      ),
    );
  }
}

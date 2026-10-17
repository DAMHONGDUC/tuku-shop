import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_list_state.dart';

/// One paged product list: a home strip, a category grid or search results.
/// Page 1 replaces the list; later pages append, so what has loaded stays on
/// screen.
class ProductListController extends Cubit<ProductListState> {
  ProductListController(this._getProductsUsecase)
    : super(const ProductListState());

  final GetProductsUsecase _getProductsUsecase;

  /// Guards against a slow, stale page 1 landing after a newer query.
  int _requestId = 0;
  Timer? _debounce;

  static const searchDebounce = Duration(milliseconds: 300);

  /// Runs [keyword] once typing pauses; an empty keyword clears the list.
  void search(String keyword) {
    _debounce?.cancel();
    if (keyword.trim().isEmpty) {
      _requestId++;
      emit(const ProductListState());
      return;
    }
    _debounce = Timer(
      searchDebounce,
      () => load(state.query.copyWith(keyword: keyword.trim())),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> load(ProductQuery query) async {
    final requestId = ++_requestId;
    final firstPage = query.firstPage();
    emit(
      state.copyWith(
        status: ProductListStatus.loading,
        query: firstPage,
        items: const [],
        hasMore: false,
        isLoadingMore: false,
        loadMoreFailed: false,
      ),
    );

    final result = await _getProductsUsecase.call(firstPage);
    if (requestId != _requestId || isClosed) return;

    result.fold(
      (_) => emit(state.copyWith(status: ProductListStatus.error)),
      (data) => emit(
        state.copyWith(
          status: ProductListStatus.loaded,
          items: data.items,
          totalRecord: data.totalRecord,
          hasMore: data.currentPage < data.totalPage,
        ),
      ),
    );
  }

  Future<void> refresh() => load(state.query);

  Future<void> changeSort(ProductSort sort) =>
      load(state.query.copyWith(sort: sort));

  Future<void> toggleOnSaleOnly() =>
      load(state.query.copyWith(onSaleOnly: !state.query.onSaleOnly));

  Future<void> loadMore() async {
    if (state.status != ProductListStatus.loaded ||
        !state.hasMore ||
        state.isLoadingMore) {
      return;
    }

    final requestId = _requestId;
    final next = state.query.nextPage();
    emit(state.copyWith(isLoadingMore: true, loadMoreFailed: false));

    final result = await _getProductsUsecase.call(next);
    if (requestId != _requestId || isClosed) return;

    result.fold(
      (_) => emit(state.copyWith(isLoadingMore: false, loadMoreFailed: true)),
      (data) => emit(
        state.copyWith(
          query: next,
          items: [...state.items, ...data.items],
          totalRecord: data.totalRecord,
          hasMore: data.currentPage < data.totalPage,
          isLoadingMore: false,
        ),
      ),
    );
  }
}

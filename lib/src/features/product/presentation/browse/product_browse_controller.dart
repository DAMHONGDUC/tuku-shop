import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_browse_state.dart';

/// A filterable, sortable, paged product grid — the shop tab, a category
/// list and search results all run on this.
class ProductBrowseController extends Cubit<ProductBrowseState> {
  ProductBrowseController({
    required this._getProducts,
    required this._getCategories,
  }) : super(const ProductBrowseState());

  final GetProductsUsecase _getProducts;
  final GetCategoriesUsecase _getCategories;

  /// Guards against an older, slower page landing after a newer query.
  int _request = 0;

  Future<void> init(ProductQuery query) async {
    emit(state.copyWith(query: query));
    await Future.wait(<Future<void>>[_loadCategories(), _reload()]);
  }

  Future<void> _loadCategories() async {
    final Either<Failure, List<CategoryEntity>> result = await _getCategories(
      const NoParams(),
    );
    result.fold(
      (Failure _) {},
      (List<CategoryEntity> c) => emit(state.copyWith(categories: c)),
    );
  }

  Future<void> setGender(Gender gender) =>
      _apply(state.query.copyWith(gender: gender));

  Future<void> setCategory(String? id) =>
      _apply(state.query.copyWith(categoryId: () => id));

  Future<void> setSort(ProductSort sort) =>
      _apply(state.query.copyWith(sort: sort));

  Future<void> setKeyword(String keyword) =>
      _apply(state.query.copyWith(keyword: keyword.trim()));

  Future<void> applyFilters(ProductQuery filters) => _apply(filters);

  Future<void> clearFilters() => _apply(state.query.cleared());

  Future<void> refresh() => _reload();

  Future<void> _apply(ProductQuery query) async {
    if (query == state.query.copyWith(page: query.page)) return;

    emit(state.copyWith(query: query.copyWith(page: 1)));
    await _reload();
  }

  Future<void> _reload() async {
    final int request = ++_request;

    emit(state.copyWith(status: LoadStatus.loading, loadingMore: false));

    final Either<Failure, ProductPage> result = await _getProducts(
      state.query.copyWith(page: 1),
    );

    if (request != _request) return;

    result.fold(
      (Failure _) => emit(state.copyWith(status: LoadStatus.failure)),
      (ProductPage page) => emit(
        state.copyWith(
          status: LoadStatus.success,
          products: page.items,
          page: 1,
          hasMore: page.hasMore,
          total: page.total,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.status != LoadStatus.success ||
        !state.hasMore ||
        state.loadingMore) {
      return;
    }

    final int request = _request;
    emit(state.copyWith(loadingMore: true));

    final Either<Failure, ProductPage> result = await _getProducts(
      state.query.copyWith(page: state.page + 1),
    );

    if (request != _request) return;

    result.fold(
      (Failure _) => emit(state.copyWith(loadingMore: false)),
      (ProductPage page) => emit(
        state.copyWith(
          products: <ProductEntity>[...state.products, ...page.items],
          page: page.page,
          hasMore: page.hasMore,
          loadingMore: false,
        ),
      ),
    );
  }
}

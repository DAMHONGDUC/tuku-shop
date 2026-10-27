import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'search_filters_state.dart';

/// The options the filter sheet offers: the catalog's sizes, colors and
/// price range, and the categories. Both requests start together.
class SearchFiltersController extends Cubit<SearchFiltersState> {
  SearchFiltersController(
    this._getProductFacetsUsecase,
    this._getCategoriesUsecase,
  ) : super(const SearchFiltersState());

  final GetProductFacetsUsecase _getProductFacetsUsecase;
  final GetCategoriesUsecase _getCategoriesUsecase;

  Future<void> load() async {
    emit(const SearchFiltersState());
    final facetsRequest = _getProductFacetsUsecase.call(NoParams());
    final categoriesRequest = _getCategoriesUsecase.call(NoParams());
    final facets = await facetsRequest;
    final categories = await categoriesRequest;
    if (isClosed) return;

    facets.fold(
      (_) => emit(const SearchFiltersState(status: SearchFiltersStatus.error)),
      (f) => categories.fold(
        (_) =>
            emit(const SearchFiltersState(status: SearchFiltersStatus.error)),
        (c) => emit(
          SearchFiltersState(
            status: SearchFiltersStatus.loaded,
            facets: f,
            categories: c,
          ),
        ),
      ),
    );
  }
}

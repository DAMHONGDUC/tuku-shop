import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'search_state.dart';

/// The suggestions half of search: recent and trending terms. Results run
/// on a `ProductBrowseController` beside it.
class ProductSearchController extends Cubit<ProductSearchState> {
  ProductSearchController({
    required this._getRecent,
    required this._saveRecent,
    required this._clearRecent,
    required this._getTrending,
  }) : super(const ProductSearchState());

  final GetRecentSearchesUsecase _getRecent;
  final SaveRecentSearchUsecase _saveRecent;
  final ClearRecentSearchesUsecase _clearRecent;
  final GetTrendingSearchesUsecase _getTrending;

  Future<void> load() async {
    final (
      Either<Failure, List<String>> recent,
      Either<Failure, List<String>> trending,
    ) = await (
      _getRecent(const NoParams()),
      _getTrending(const NoParams()),
    ).wait;

    emit(
      ProductSearchState(
        recent: recent.getOrElse(() => const <String>[]),
        trending: trending.getOrElse(() => const <String>[]),
      ),
    );
  }

  void setKeyword(String keyword) =>
      emit(state.copyWith(keyword: keyword.trim()));

  Future<void> remember(String keyword) async {
    if (keyword.trim().isEmpty) return;

    final Either<Failure, List<String>> result = await _saveRecent(keyword);
    result.fold(
      (Failure _) {},
      (List<String> r) => emit(state.copyWith(recent: r)),
    );
  }

  Future<void> clearRecent() async {
    await _clearRecent(const NoParams());
    emit(state.copyWith(recent: const <String>[]));
  }
}

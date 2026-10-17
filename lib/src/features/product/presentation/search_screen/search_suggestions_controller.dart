import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'search_suggestions_state.dart';

/// Recent and trending searches shown before the user types.
class SearchSuggestionsController extends Cubit<SearchSuggestionsState> {
  SearchSuggestionsController(
    this._getSuggestionsUsecase,
    this._saveRecentSearchUsecase,
    this._clearRecentSearchesUsecase,
  ) : super(const SearchSuggestionsState());

  final GetSearchSuggestionsUsecase _getSuggestionsUsecase;
  final SaveRecentSearchUsecase _saveRecentSearchUsecase;
  final ClearRecentSearchesUsecase _clearRecentSearchesUsecase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getSuggestionsUsecase.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(isLoading: false)),
      (data) => emit(
        SearchSuggestionsState(
          isLoading: false,
          recent: data.recent,
          trending: data.trending,
        ),
      ),
    );
  }

  Future<void> save(String keyword) async {
    final trimmed = keyword.trim();
    if (trimmed.isEmpty) return;
    emit(
      state.copyWith(
        recent: [
          trimmed,
          ...state.recent.where(
            (k) => k.toLowerCase() != trimmed.toLowerCase(),
          ),
        ].take(8).toList(),
      ),
    );
    await _saveRecentSearchUsecase.call(trimmed);
  }

  Future<void> clearRecent() async {
    emit(state.copyWith(recent: const []));
    await _clearRecentSearchesUsecase.call(NoParams());
  }
}

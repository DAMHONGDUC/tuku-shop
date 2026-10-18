part of 'search_suggestions_controller.dart';

class SearchSuggestionsState extends Equatable {
  final bool isLoading;
  final List<String> recent;
  final List<String> trending;

  const SearchSuggestionsState({
    this.isLoading = true,
    this.recent = const [],
    this.trending = const [],
  });

  SearchSuggestionsState copyWith({
    bool? isLoading,
    List<String>? recent,
    List<String>? trending,
  }) {
    return SearchSuggestionsState(
      isLoading: isLoading ?? this.isLoading,
      recent: recent ?? this.recent,
      trending: trending ?? this.trending,
    );
  }

  @override
  List<Object?> get props => [isLoading, recent, trending];
}

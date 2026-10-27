part of 'search_filters_controller.dart';

enum SearchFiltersStatus { loading, loaded, error }

class SearchFiltersState extends Equatable {
  final SearchFiltersStatus status;
  final ProductFacets? facets;
  final List<CategoryEntity> categories;

  const SearchFiltersState({
    this.status = SearchFiltersStatus.loading,
    this.facets,
    this.categories = const [],
  });

  @override
  List<Object?> get props => [status, facets, categories];
}

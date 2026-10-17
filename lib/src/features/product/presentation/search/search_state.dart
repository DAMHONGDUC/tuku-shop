part of 'search_controller.dart';

class ProductSearchState extends Equatable {
  const ProductSearchState({
    this.keyword = '',
    this.recent = const <String>[],
    this.trending = const <String>[],
  });

  final String keyword;
  final List<String> recent;
  final List<String> trending;

  bool get showSuggestions => keyword.isEmpty;

  ProductSearchState copyWith({
    String? keyword,
    List<String>? recent,
    List<String>? trending,
  }) => ProductSearchState(
    keyword: keyword ?? this.keyword,
    recent: recent ?? this.recent,
    trending: trending ?? this.trending,
  );

  @override
  List<Object> get props => <Object>[keyword, recent, trending];
}

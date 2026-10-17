import 'package:equatable/equatable.dart';

class SearchSuggestions extends Equatable {
  final List<String> recent;
  final List<String> trending;

  const SearchSuggestions({required this.recent, required this.trending});

  @override
  List<Object?> get props => [recent, trending];
}

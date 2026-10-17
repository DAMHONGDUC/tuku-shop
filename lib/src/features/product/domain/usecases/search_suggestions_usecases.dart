import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class GetSearchSuggestionsUsecase
    implements UseCase<SearchSuggestions, NoParams> {
  final ProductRepository repository;

  GetSearchSuggestionsUsecase(this.repository);

  @override
  Future<Either<Failure, SearchSuggestions>> call(NoParams params) {
    return repository.getSearchSuggestions();
  }
}

class SaveRecentSearchUsecase implements UseCase<Unit, String> {
  final ProductRepository repository;

  SaveRecentSearchUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String params) {
    final keyword = params.trim();
    if (keyword.isEmpty) return Future.value(const Right(unit));
    return repository.saveRecentSearch(keyword);
  }
}

class ClearRecentSearchesUsecase implements UseCase<Unit, NoParams> {
  final ProductRepository repository;

  ClearRecentSearchesUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.clearRecentSearches();
  }
}

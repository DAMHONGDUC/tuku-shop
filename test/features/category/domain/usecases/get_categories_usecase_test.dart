import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_repositories.dart';

void main() {
  late MockCategoryRepository repository;
  late GetCategoriesUsecase usecase;

  setUp(() {
    repository = MockCategoryRepository();
    usecase = GetCategoriesUsecase(repository);
  });

  const tCategories = [
    CategoryEntity(
      id: 'women-tops',
      name: 'Luxury',
      imageUrl: 'assets/images/category/c0.png',
      numOfProduct: 120,
    ),
  ];

  test('should return categories from the repository on success', () async {
    when(
      () => repository.getCategories(),
    ).thenAnswer((_) async => const Right(tCategories));

    final result = await usecase.call(NoParams());

    expect(result, const Right(tCategories));
    verify(() => repository.getCategories()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return a Failure when the repository fails', () async {
    final failure = ServerFailure();
    when(
      () => repository.getCategories(),
    ).thenAnswer((_) async => Left(failure));

    final result = await usecase.call(NoParams());

    expect(result, Left(failure));
  });
}

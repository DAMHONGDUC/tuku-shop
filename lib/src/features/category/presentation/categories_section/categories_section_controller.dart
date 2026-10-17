import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';

part 'categories_section_state.dart';

class CategoriesSectionController extends Cubit<CategoriesSectionState> {
  CategoriesSectionController(this._getCategories)
    : super(const CategoriesSectionState());

  final GetCategoriesUsecase _getCategories;

  Future<void> load() async {
    emit(const CategoriesSectionState());

    final Either<Failure, List<CategoryEntity>> result = await _getCategories(
      const NoParams(),
    );

    result.fold(
      (Failure _) =>
          emit(const CategoriesSectionState(status: LoadStatus.failure)),
      (List<CategoryEntity> categories) => emit(
        CategoriesSectionState(
          status: LoadStatus.success,
          categories: categories,
        ),
      ),
    );
  }
}

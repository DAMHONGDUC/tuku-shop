part of 'categories_section_controller.dart';

class CategoriesSectionState extends Equatable {
  const CategoriesSectionState({
    this.status = LoadStatus.loading,
    this.categories = const <CategoryEntity>[],
  });

  final LoadStatus status;
  final List<CategoryEntity> categories;

  @override
  List<Object> get props => <Object>[status, categories];
}

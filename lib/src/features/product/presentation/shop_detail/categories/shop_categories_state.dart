part of 'shop_categories_controller.dart';

enum ShopCategoriesStatus { loading, loaded, error }

typedef ShopCategory = ({CategoryEntity category, int count});

class ShopCategoriesState extends Equatable {
  final ShopCategoriesStatus status;
  final List<ShopCategory> items;

  const ShopCategoriesState({
    this.status = ShopCategoriesStatus.loading,
    this.items = const [],
  });

  @override
  List<Object?> get props => [status, items];
}

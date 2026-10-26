import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'shop_categories_state.dart';

/// The categories one shop sells, each with how many of its listings it
/// holds, in the catalog's category order.
class ShopCategoriesController extends Cubit<ShopCategoriesState> {
  ShopCategoriesController(this._getProducts, this._getCategories)
    : super(const ShopCategoriesState());

  final GetProductsUsecase _getProducts;
  final GetCategoriesUsecase _getCategories;

  /// Enough to cover any one shop's listings in a single page.
  static const _allListings = 500;

  Future<void> load(String sellerId) async {
    emit(const ShopCategoriesState());
    final productsRequest = _getProducts.call(
      ProductQuery(sellerId: sellerId, pageSize: _allListings),
    );
    final categoriesRequest = _getCategories.call(NoParams());
    final products = await productsRequest;
    final categories = await categoriesRequest;
    if (isClosed) return;

    products.fold(
      (_) =>
          emit(const ShopCategoriesState(status: ShopCategoriesStatus.error)),
      (page) => categories.fold(
        (_) =>
            emit(const ShopCategoriesState(status: ShopCategoriesStatus.error)),
        (all) {
          final counts = <String, int>{};
          for (final p in page.items) {
            counts[p.categoryId] = (counts[p.categoryId] ?? 0) + 1;
          }
          emit(
            ShopCategoriesState(
              status: ShopCategoriesStatus.loaded,
              items: [
                for (final c in all)
                  if (counts.containsKey(c.id))
                    (category: c, count: counts[c.id]!),
              ],
            ),
          );
        },
      ),
    );
  }
}

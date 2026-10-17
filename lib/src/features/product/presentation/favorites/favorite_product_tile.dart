import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/product_entity_tile.dart';

/// A product tile whose heart follows the app-wide [FavoritesController].
class FavoriteProductTile extends StatelessWidget {
  const FavoriteProductTile({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesController, FavoritesState, bool>(
      selector: (state) => state.contains(product.id),
      builder: (context, isFavorite) => ProductEntityTile(
        product: product,
        isFavorite: isFavorite,
        onFavoriteTap: () =>
            context.read<FavoritesController>().toggle(product.id),
      ),
    );
  }
}

import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/product_detail_args.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/config/product_routes.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/product_card.dart';
import 'package:tuku_shop/src/features/product/presentation/widgets/product_grid_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import 'related_products_controller.dart';

class RelatedProductsSection extends StatelessWidget {
  const RelatedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SdSpacingV5.s16,
        vertical: SdSpacingV5.s12,
      ),
      color: context.colorTheme.surfaceDefault,
      child: BlocConsumer<RelatedProductsController, RelatedProductsState>(
        listener: (context, state) {
          // TODO: implement listener if need
        },
        buildWhen: (previous, current) {
          return current is RelatedProductsLoadingState ||
              current is RelatedProductsLoadedState;
        },
        builder: (context, state) {
          if (state is RelatedProductsLoadingState) {
            return ProductGridSkeleton();
          } else if (state is RelatedProductsLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Related products', style: SdTextStyleV5.heading18()),
                SdVerticalSpacingV5(),
                SdGridViewV5(
                  items: state.products,
                  gridCrossAxisCount: 2,
                  gridMainAxisSpacing: SdSpacingV5.s16,
                  gridCrossAxisSpacing: SdSpacingV5.s16,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCard(
                      product: product,
                      onPress: () {
                        GoRouter.of(context).push(
                          ProductRoutes.productDetail.fullPath,
                          extra: ProductDetailArgs(productId: product.id),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

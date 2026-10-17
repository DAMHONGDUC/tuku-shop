import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/color_selection_section/color_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

import 'product_detail_app_bar_controller.dart';

class ProductDetailAppBar extends StatelessWidget {
  final ProductEntity product;
  final double imgHeight;

  const ProductDetailAppBar({
    super.key,
    required this.product,
    required this.imgHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: imgHeight,
      pinned: true,
      floating: false,
      backgroundColor: context.colorTheme.surfaceDefault,
      surfaceTintColor: Colors.transparent,
      elevation: SdSpacingV5.s2,
      shadowColor: context.colorTheme.primaryShadowDefault,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      flexibleSpace: _ImageSection(product: product),
      title: _TitleSection(imgHeight: imgHeight),
      actions: [_ActionSection(imgHeight: imgHeight)],
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.imgHeight});
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailAppBarController, ProductDetailAppBarState>(
      buildWhen: (previous, current) {
        return previous.scrollOffset != current.scrollOffset;
      },
      builder: (context, state) {
        return Row(
          children: [
            SdFadingIconV5(
              iconData: SdHelperV5.getAppBarBackIcon(),
              iconColor: state.calculateIconColor(
                context: context,
                imgHeight: imgHeight,
              ),
              bgColor: state.calculateIconBgColor(
                context: context,
                imgHeight: imgHeight,
              ),
              iconSize: SdSpacingV5.s24,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SdHorizontalSpacingV5(),
            Expanded(
              child: SdFadeWrapperV5(
                progress: state.calculateProgress(imgHeight: imgHeight),
                child: CustomSearchBar(
                  bgColor: context.colorTheme.cardOnSurface,
                  hasBorder: false,
                  searchIconSize: SdSpacingV5.s20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({required this.imgHeight});
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailAppBarController, ProductDetailAppBarState>(
      buildWhen: (previous, current) {
        return previous.scrollOffset != current.scrollOffset;
      },
      builder: (context, state) {
        final iconColor = state.calculateIconColor(
          context: context,
          imgHeight: imgHeight,
        );
        final iconBgColor = state.calculateIconBgColor(
          context: context,
          imgHeight: imgHeight,
        );

        return Row(
          children: [
            SdFadingIconV5(
              iconData: Icons.share,
              iconColor: iconColor,
              bgColor: iconBgColor,
              iconSize: SdSpacingV5.s22,
              onTap: () {},
            ),
            SdFadingIconV5(
              iconData: Icons.shopping_cart,
              iconColor: iconColor,
              bgColor: iconBgColor,
              iconSize: SdSpacingV5.s22,
              onTap: () {},
            ),
            SdFadingIconV5(
              iconData: Icons.more_vert,
              iconColor: iconColor,
              bgColor: iconBgColor,
              iconSize: SdSpacingV5.s22,
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorSelectionController, ColorSelectionState>(
      buildWhen: (previous, current) {
        return current is ColorSelectionChangedColorState;
      },
      builder: (context, state) {
        String imagePath = product.imageUrl;

        if (state is ColorSelectionChangedColorState) {
          imagePath = state.productColor.imageUrl;
        }

        return FlexibleSpaceBar(background: SdImageV5(imagePath: imagePath));
      },
    );
  }
}

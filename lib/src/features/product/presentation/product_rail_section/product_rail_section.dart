import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../widgets/product_rail.dart';
import 'product_rail_controller.dart';

/// A titled rail of products for a query, with "See all" opening the same
/// query as a full list.
class ProductRailSection extends StatelessWidget {
  const ProductRailSection({
    required this.title,
    required this.args,
    required this.heroPrefix,
    this.subtitle,
    this.limit = 8,
    super.key,
  });

  final String title;
  final String? subtitle;
  final ProductListArgs args;
  final String heroPrefix;
  final int limit;

  @override
  Widget build(BuildContext context) => BlocProvider<ProductRailController>(
    create: (BuildContext _) => getIt<ProductRailController>()
      ..load(ProductQuery.fromArgs(args).copyWith(pageSize: limit)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: SdContentPaddingV5.gutter,
          child: SdSectionHeaderV5(
            title: title,
            subtitle: subtitle,
            actionLabel: context.loc.action_see_all,
            onAction: () => context.push(AppRoutes.productListPath(args)),
          ),
        ),
        SizedBox(height: SdSpacingConstant.h14),
        BlocBuilder<ProductRailController, ProductRailState>(
          builder: (BuildContext context, ProductRailState state) =>
              FadeSwitcher(
                child: state.status == LoadStatus.success
                    ? ProductRail(products: state.products, heroPrefix: heroPrefix)
                    : const ProductRailSkeleton(),
              ),
        ),
      ],
    ),
  );
}

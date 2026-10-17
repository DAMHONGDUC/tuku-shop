import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../browse/product_browse_controller.dart';
import '../browse/product_browse_view.dart';

/// A pushed list for one entry point — a banner, a category, "See all".
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({required this.args, super.key});

  final ProductListArgs args;

  @override
  Widget build(BuildContext context) => BlocProvider<ProductBrowseController>(
    create: (BuildContext _) =>
        getIt<ProductBrowseController>()..init(ProductQuery.fromArgs(args)),
    child: SdScaffoldV5(
      appBar: SdAppBarV5(
        title: args.title ?? context.loc.shop_title,
        actions: <Widget>[
          SdIconButtonV5(
            icon: Symbols.search_rounded,
            tooltip: context.loc.search_title,
            onPressed: () => context.push(AppRoutes.search.path),
          ),
        ],
      ),
      body: BrowseScrollListener(
        child: CustomScrollView(
          slivers: <Widget>[
            ProductBrowseSlivers(
              heroPrefix: 'list',
              showGenderTabs: args.gender == Gender.all,
              showCategories: args.categoryId == null,
              bottomInset: SdContentPaddingV5.detailBottom(context),
            ),
          ],
        ),
      ),
    ),
  );
}

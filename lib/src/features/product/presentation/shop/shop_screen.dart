import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../browse/product_browse_controller.dart';
import '../browse/product_browse_view.dart';

/// The Shop tab: the whole catalogue, narrowed by gender, category, sort and
/// filters.
class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ProductBrowseController>(
    create: (BuildContext _) =>
        getIt<ProductBrowseController>()..init(const ProductQuery()),
    child: Builder(
      builder: (BuildContext context) => SdScaffoldV5(
        body: BrowseScrollListener(
          child: RefreshIndicator.adaptive(
            onRefresh: context.read<ProductBrowseController>().refresh,
            color: context.sdTheme5.textPrimary,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: SdContentPaddingV5.gutter.copyWith(
                      top:
                          SdContentPaddingV5.statusBarInset(context) +
                          SdSpacingConstant.h16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SdFadeInV5(
                          child: Text(
                            context.loc.shop_title,
                            style: context.textTheme5.displaySmall,
                          ),
                        ),
                        SizedBox(height: SdSpacingConstant.h14),
                        SdSearchFieldV5(
                          hint: context.loc.search_hint,
                          onTap: () => context.push(AppRoutes.search.path),
                        ),
                        SizedBox(height: SdSpacingConstant.h8),
                      ],
                    ),
                  ),
                ),
                ProductBrowseSlivers(
                  heroPrefix: 'shop',
                  bottomInset: SdContentPaddingV5.aboveNavBar(context),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

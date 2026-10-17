import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';

import 'categories_section_controller.dart';

/// A row of round category portraits under the banners.
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocProvider<CategoriesSectionController>(
    create: (BuildContext _) => getIt<CategoriesSectionController>()..load(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: SdContentPaddingV5.gutter,
          child: SdSectionHeaderV5(
            title: context.loc.home_categories,
            actionLabel: context.loc.action_see_all,
            onAction: () => context.go(AppRoutes.shop.path),
          ),
        ),
        SizedBox(height: SdSpacingConstant.h14),
        SizedBox(
          height: _CategoryTile.height,
          child:
              BlocBuilder<CategoriesSectionController, CategoriesSectionState>(
                builder: (BuildContext context, CategoriesSectionState state) =>
                    FadeSwitcher(
                      child: state.status == LoadStatus.success
                          ? _CategoryList(categories: state.categories)
                          : const _CategorySkeleton(),
                    ),
              ),
        ),
      ],
    ),
  );
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({required this.categories});

  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) => ListView.separated(
    scrollDirection: Axis.horizontal,
    padding: SdContentPaddingV5.gutter,
    itemCount: categories.length,
    separatorBuilder: (_, _) => SizedBox(width: SdSpacingConstant.w14),
    itemBuilder: (BuildContext context, int i) => SdFadeInV5(
      index: i,
      child: _CategoryTile(category: categories[i]),
    ),
  );
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category});

  final CategoryEntity category;

  static double get diameter => SdSpacingConstant.r64 * 1.1;

  static double get height => diameter + SdSpacingConstant.h32;

  @override
  Widget build(BuildContext context) => SdPressableV5(
    semanticLabel: category.name,
    onTap: () => context.push(
      Uri(
        path: AppRoutes.productList.path,
        queryParameters: ProductListArgs(
          title: category.name,
          categoryId: category.id,
        ).toQuery(),
      ).toString(),
    ),
    child: SizedBox(
      width: diameter,
      child: Column(
        children: <Widget>[
          Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.sdTheme5.border),
            ),
            child: ClipOval(child: AppImage(category.image)),
          ),
          SizedBox(height: SdSpacingConstant.h8),
          Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme5.labelMedium!.semiBold5,
          ),
        ],
      ),
    ),
  );
}

class _CategorySkeleton extends StatelessWidget {
  const _CategorySkeleton();

  @override
  Widget build(BuildContext context) => SdShimmerV5(
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: SdContentPaddingV5.gutter,
      itemCount: 6,
      separatorBuilder: (_, _) => SizedBox(width: SdSpacingConstant.w14),
      itemBuilder: (_, _) => Column(
        children: <Widget>[
          SdSkeletonV5(
            width: _CategoryTile.diameter,
            height: _CategoryTile.diameter,
          ),
          SizedBox(height: SdSpacingConstant.h8),
          SdSkeletonV5(
            width: _CategoryTile.diameter * 0.7,
            height: SdSpacingConstant.h12,
          ),
        ],
      ),
    ),
  );
}

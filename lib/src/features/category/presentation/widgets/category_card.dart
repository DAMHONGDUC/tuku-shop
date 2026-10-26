import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';

void openCategory(BuildContext context, CategoryEntity category) {
  context.push(
    ProductRoutes.productListLocation(
      title: category.name,
      categoryId: category.id,
    ),
  );
}

/// Round photo and name, for the Home strip.
class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: () => openCategory(context, category),
        child: SizedBox(
          width: UIConstants.categoriesCardWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: UIConstants.categoriesImageWidth,
                height: UIConstants.categoriesImageHeight,
                padding: EdgeInsets.all(SdSpacingV5.s2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colorTheme.borderDefault),
                ),
                child: ClipOval(
                  child: ColoredBox(
                    color: context.colorTheme.cardOnSurface,
                    child: CatalogImage(path: category.imageUrl),
                  ),
                ),
              ),
              SdVerticalSpacingV5(value: SdSpacingV5.s8),
              Text(
                category.name,
                style: SdTextStyleV5.body12().wColor(
                  context.colorTheme.textDefault,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A neutral card with a product photo and a serif name, for the
/// Categories tab.
class CategoryGridCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryGridCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Material(
      color: colors.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openCategory(context, category),
        child: Stack(
          children: [
            Positioned(
              right: -SdSpacingV5.s8,
              bottom: -SdSpacingV5.s8,
              width: 84,
              height: 104,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UIConstants.imageRadius),
                  boxShadow: [
                    BoxShadow(
                      color: colors.boxShadowDefault,
                      blurRadius: SdSpacingV5.s14,
                      offset: const Offset(0, SdSpacingV5.s6),
                    ),
                  ],
                ),
                child: CatalogImage(
                  path: category.imageUrl,
                  borderRadius: UIConstants.imageRadius,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SdSpacingV5.s12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96,
                    child: Text(
                      category.name,
                      maxLines: 2,
                      style: SdTextStyleV5.heading16()
                          .wColor(colors.textDefault)
                          .wDisplay(),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    context.loc.common_items_count(category.numOfProduct),
                    style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

Color _parseHex(String hex) =>
    Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));

/// Round thumbnail and name, for the Home strip.
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
                padding: EdgeInsets.all(SdSpacingV5.s4),
                decoration: BoxDecoration(
                  color: _parseHex(category.colorHex),
                  borderRadius: BorderRadius.circular(SdSpacingV5.s16),
                ),
                child: CatalogImage(
                  path: category.imageUrl,
                  borderRadius: SdSpacingV5.s12,
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

/// Color-coded card with a product photo, for the Categories tab.
class CategoryGridCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryGridCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _parseHex(category.colorHex),
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
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: SdSpacingV5.s14,
                      offset: Offset(0, SdSpacingV5.s6),
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
                      style: SdTextStyleV5.body14().wSemiBold().wColor(
                        const Color(0xFF15151A),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    context.loc.common_items_count(category.numOfProduct),
                    style: SdTextStyleV5.body12().wColor(
                      const Color(0xFF4A4A55),
                    ),
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

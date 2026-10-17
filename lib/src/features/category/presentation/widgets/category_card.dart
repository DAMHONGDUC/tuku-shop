import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UIConstants.categoriesCardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SdImageV5(
            imagePath: category.imageUrl,
            width: UIConstants.categoriesImageWidth,
            height: UIConstants.categoriesImageHeight,
            borderRadiusValue: SdSpacingV5.s100,
          ),
          SdVerticalSpacingV5(xRatio: 0.5),
          Text(
            category.name,
            style: context.textTheme.heading14,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

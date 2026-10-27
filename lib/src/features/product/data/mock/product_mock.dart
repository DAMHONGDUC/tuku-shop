import 'dart:math';

import 'package:tuku_shop/src/features/product/data/mock/product_description_mock.dart';
import 'package:tuku_shop/src/features/product/data/mock/review_comment_mock.dart';
import 'package:tuku_shop/src/features/product/data/models/description_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_color_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_size_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_variant_model.dart';
import 'package:tuku_shop/src/features/product/domain/entities/product_tag.dart';

part 'catalog_mock.dart';

/// Size scales used by the catalog.
class _Sizes {
  static const xsToXl = ['XS', 'S', 'M', 'L', 'XL'];
  static const sToXxl = ['S', 'M', 'L', 'XL', 'XXL'];
  static const waist = ['28', '30', '32', '34', '36'];
  static const kids = ['2Y', '4Y', '6Y', '8Y', '10Y', '12Y'];
  static const shoes = ['36', '37', '38', '39', '40', '41', '42', '43', '44'];
  static const oneSize = ['One size'];
  static const iphones = [
    'iPhone 13',
    'iPhone 14',
    'iPhone 15',
    'iPhone 16',
    'iPhone 17',
    'iPhone 17 Pro',
    'iPhone 17 Pro Max',
  ];
}

class _CatalogRow {
  final String id;
  final String categoryId;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final List<ProductTag> tags;
  final List<(String, String)> colors;
  final String material;
  final String fit;
  final List<String> sizes;
  final List<String> images;

  /// `model` when [sizes] lists device models instead of garment sizes.
  final String secondOption;

  const _CatalogRow({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.tags,
    required this.colors,
    required this.material,
    required this.fit,
    required this.sizes,
    required this.images,
    this.secondOption = 'size',
  });
}

class ProductMock {
  // Fixed seed: the same ratings, stock and reviews on every launch.
  static final _random = Random(42);

  static const reviewsPerProduct = 24;

  static int _between(int min, int max) => min + _random.nextInt(max - min + 1);

  static double _rating() =>
      double.parse((3.8 + _random.nextDouble() * 1.1).toStringAsFixed(1));

  /// Shops carrying each brand; listings of a brand alternate between them,
  /// so the official store and resellers both appear.
  static const _sellersByBrand = {
    'Aurora': ['aurora-official', 'saigon-closet'],
    'Northline': ['northline-official', 'denim-house'],
    'Stride': ['stride-sports'],
    'Tuku Studio': ['tuku-studio'],
    'Tuku Basics': ['tuku-basics'],
    'Kinfolk Kids': ['kinfolk-kids'],
  };

  static String _sellerFor(_CatalogRow row) {
    final shops = _sellersByBrand[row.brand] ?? const ['tuku-studio'];
    final nth = _catalog
        .where((r) => r.brand == row.brand)
        .toList()
        .indexOf(row);
    return shops[nth % shops.length];
  }

  static ProductModel _build(_CatalogRow row) {
    final colors = [
      for (var i = 0; i < row.colors.length; i++)
        ProductColorModel(
          colorName: row.colors[i].$1,
          colorCode: row.colors[i].$2,
          imageUrl: row.images[i % row.images.length],
        ),
    ];

    final variants = [
      for (final color in row.colors)
        for (final size in row.sizes)
          ProductVariantModel(
            colorName: color.$1,
            size: size,
            // About one variant in eight is sold out.
            stock: _random.nextInt(8) == 0 ? 0 : _between(1, 15),
          ),
    ];

    return ProductModel(
      id: row.id,
      categoryId: row.categoryId,
      name: row.name,
      brand: row.brand,
      sellerId: _sellerFor(row),
      price: row.price,
      originalPrice: row.originalPrice,
      tags: row.tags.map((t) => t.name).toList(),
      imageUrl: row.images.first,
      images: row.images,
      productColors: colors,
      secondOption: row.secondOption,
      productSizes: [
        for (final size in row.sizes) ProductSizeModel(id: size, name: size),
      ],
      variants: variants,
      material: row.material,
      fit: row.fit,
      purchaserCount: _between(40, 2400),
      averageRating: _rating(),
      ratingCount: _between(18, 480),
      reviewComments: ReviewCommentMock.generateRandomReviews(
        reviewsPerProduct,
        photos: row.images,
        sizes: row.sizes,
        colors: [for (final c in row.colors) c.$1],
        sizesAreModels: row.secondOption == 'model',
      ),
      description: DescriptionModel(
        content: ProductDescriptionMock.generate(
          categoryId: row.categoryId,
          forDevice: row.secondOption == 'model',
          material: row.material,
          fit: row.fit,
        ),
        // Every product photo also illustrates the description.
        images: row.images,
      ),
    );
  }

  static final List<ProductModel> products = _catalog.map(_build).toList();
}

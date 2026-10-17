import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/data/models/category_model.dart';

abstract final class CategoryMock {
  static final List<CategoryModel> categories = <CategoryModel>[
    CategoryModel(id: 'hoodies', name: 'Hoodies', image: AppAssets.category('hoodies'), productCount: 8),
    CategoryModel(id: 'jackets', name: 'Jackets', image: AppAssets.category('jackets'), productCount: 8),
    CategoryModel(id: 'tees', name: 'Tees', image: AppAssets.category('tees'), productCount: 8),
    CategoryModel(id: 'tanks', name: 'Tanks & Bras', image: AppAssets.category('tanks'), productCount: 8),
    CategoryModel(id: 'pants', name: 'Pants', image: AppAssets.category('pants'), productCount: 8),
    CategoryModel(id: 'shorts', name: 'Shorts', image: AppAssets.category('shorts'), productCount: 8),
    CategoryModel(id: 'bags', name: 'Bags', image: AppAssets.category('bags'), productCount: 6),
  ];
}

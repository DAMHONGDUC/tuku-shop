import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// A small product with two colors and three sizes; M in Black is sold out.
ProductEntity tProduct({String id = 'p1', double price = 50}) => ProductEntity(
  id: id,
  name: 'Product $id',
  brand: 'Brand',
  price: price,
  imageUrl: 'a.jpg',
  images: const ['a.jpg', 'b.jpg'],
  purchaserCount: 10,
  reviewComments: const [],
  averageRating: 4.5,
  productColors: const [
    ProductColor(colorName: 'Black', imageUrl: 'a.jpg', colorCode: '#000000'),
    ProductColor(colorName: 'White', imageUrl: 'b.jpg', colorCode: '#FFFFFF'),
  ],
  productSizes: const [
    ProductSize(id: 'S', name: 'S'),
    ProductSize(id: 'M', name: 'M'),
    ProductSize(id: 'L', name: 'L'),
  ],
  variants: const [
    ProductVariant(colorName: 'Black', size: 'S', stock: 3),
    ProductVariant(colorName: 'Black', size: 'M', stock: 0),
    ProductVariant(colorName: 'Black', size: 'L', stock: 12),
    ProductVariant(colorName: 'White', size: 'S', stock: 5),
    ProductVariant(colorName: 'White', size: 'M', stock: 5),
    ProductVariant(colorName: 'White', size: 'L', stock: 0),
  ],
);

ProductsData tPage(List<ProductEntity> items, {int page = 1, int pages = 2}) =>
    ProductsData(
      items: items,
      totalPage: pages,
      currentPage: page,
      totalRecord: items.length * pages,
    );

import 'package:tuku_shop/src/features/cart/data/models/cart_line_model.dart';

const _kCatalogPath = 'assets/images/catalog/';

/// Two lines on first launch, so the cart badge is not empty in the demo.
class CartMock {
  static const seedLines = [
    CartLineModel(
      productId: 'wd1',
      name: 'Floral Midi Dress',
      brand: 'Aurora',
      imageUrl: '${_kCatalogPath}women-dresses/wd1_1.jpg',
      colorName: 'Black Floral',
      size: 'S',
      unitPrice: 69,
      quantity: 1,
      maxQuantity: 6,
    ),
    CartLineModel(
      productId: 'sh4',
      name: 'Canvas High-Tops',
      brand: 'Northline',
      imageUrl: '${_kCatalogPath}shoes/sh4_1.jpg',
      colorName: 'Black',
      size: '41',
      unitPrice: 59,
      quantity: 1,
      maxQuantity: 10,
    ),
  ];
}

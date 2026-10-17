import 'package:tuku_shop/src/core/core.dart';

/// An order line as the order service stores it: a snapshot of the product
/// at purchase time, not a live reference to the catalog.
class OrderModel {
  final String? id;
  final String? productName;
  final String? productId;
  final int? quantity;
  final OrderStatus? status;
  final double? totalPrice;
  final String? productThumbnailUrl;
  final String? colorName;
  final String? colorCode;
  final String? sizeName;

  const OrderModel({
    this.id,
    this.productName,
    this.productId,
    this.quantity,
    this.status,
    this.totalPrice,
    this.productThumbnailUrl,
    this.colorName,
    this.colorCode,
    this.sizeName,
  });

  OrderModel copyWith({
    String? id,
    String? productName,
    String? productId,
    int? quantity,
    OrderStatus? status,
    double? totalPrice,
    String? productThumbnailUrl,
    String? colorName,
    String? colorCode,
    String? sizeName,
  }) {
    return OrderModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      productThumbnailUrl: productThumbnailUrl ?? this.productThumbnailUrl,
      colorName: colorName ?? this.colorName,
      colorCode: colorCode ?? this.colorCode,
      sizeName: sizeName ?? this.sizeName,
    );
  }
}

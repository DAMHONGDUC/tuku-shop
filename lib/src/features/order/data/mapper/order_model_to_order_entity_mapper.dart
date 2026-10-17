import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';
import 'package:tuku_shop/src/features/order/domain/entities/order_entity.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class OrderModelToOrderEntityMapper {
  const OrderModelToOrderEntityMapper._();

  static OrderEntity toEntity(OrderModel model) {
    return OrderEntity(
      id: model.id ?? '',
      productName: model.productName ?? '',
      productId: model.productId ?? '',
      quantity: model.quantity ?? 0,
      status: model.status ?? OrderStatus.none,
      totalPrice: model.totalPrice ?? 0,
      productThumbnailUrl: model.productThumbnailUrl ?? '',
      productColor: ProductColor(
        colorName: model.colorName ?? '',
        colorCode: model.colorCode ?? '',
        imageUrl: model.productThumbnailUrl ?? '',
      ),
      productSize: ProductSize(
        id: model.sizeName ?? '',
        name: model.sizeName ?? '',
      ),
    );
  }
}

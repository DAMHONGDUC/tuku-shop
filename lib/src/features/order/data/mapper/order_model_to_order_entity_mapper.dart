import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/data/models/order_model.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

class OrderModelToOrderEntityMapper {
  const OrderModelToOrderEntityMapper._();

  static OrderEntity toEntity(OrderModel model) => OrderEntity(
    id: model.id ?? '',
    code: model.code ?? '',
    createdAt: model.createdAt ?? DateTime(2026),
    status: OrderStatus.fromName(model.status),
    items: (model.items ?? const <OrderItemModel>[])
        .map(
          (OrderItemModel i) => OrderItemEntity(
            productId: i.productId ?? '',
            name: i.name ?? '',
            image: i.image ?? '',
            color: i.color ?? '',
            size: i.size ?? '',
            quantity: i.quantity ?? 1,
            unitPrice: i.unitPrice ?? 0,
          ),
        )
        .toList(),
    recipient: model.recipient ?? '',
    phone: model.phone ?? '',
    address: model.address ?? '',
    paymentType: PaymentMethodType.fromName(model.paymentType),
    paymentLabel: model.paymentLabel ?? '',
    deliveryOptionId: model.deliveryOptionId ?? 'standard',
    subtotal: model.subtotal ?? 0,
    shippingFee: model.shippingFee ?? 0,
    discount: model.discount ?? 0,
    promoCode: model.promoCode,
    estimatedDelivery: model.estimatedDelivery ?? DateTime(2026),
    tracking: (model.tracking ?? const <TrackingEventModel>[])
        .map(
          (TrackingEventModel t) => TrackingEventEntity(
            status: OrderStatus.fromName(t.status),
            time: t.time ?? DateTime(2026),
            location: t.location ?? '',
          ),
        )
        .toList(),
  );

  static OrderItemModel itemToModel(OrderItemEntity item) => OrderItemModel(
    productId: item.productId,
    name: item.name,
    image: item.image,
    color: item.color,
    size: item.size,
    quantity: item.quantity,
    unitPrice: item.unitPrice,
  );
}

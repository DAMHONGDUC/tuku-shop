import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// Small, hand-built entities shared by the suites.
abstract final class Fixtures {
  static final UserEntity user = UserEntity(
    id: 'u_1',
    fullName: 'Alex Morgan',
    email: 'alex@example.com',
    phone: '+1 415 555 0132',
    memberSince: DateTime(2024, 3, 12),
    points: 2480,
  );

  static CartItemEntity cartItem({
    String productId = 'p_1',
    String color = 'Black',
    String size = 'M',
    double unitPrice = 20,
    double? compareAtPrice,
    int quantity = 1,
  }) => CartItemEntity(
    id: '$productId|$color|$size',
    productId: productId,
    name: 'Tee $productId',
    brand: 'Tuku',
    image: 'assets/images/product/tee.webp',
    color: color,
    size: size,
    unitPrice: unitPrice,
    compareAtPrice: compareAtPrice,
    quantity: quantity,
  );

  static const AddressEntity address = AddressEntity(
    id: 'a_1',
    label: 'Home',
    fullName: 'Alex Morgan',
    phone: '+1 415 555 0132',
    street: '1 Market St',
    city: 'San Francisco',
    postalCode: '94105',
    country: 'USA',
    isDefault: true,
  );

  static const AddressEntity otherAddress = AddressEntity(
    id: 'a_2',
    label: 'Office',
    fullName: 'Alex Morgan',
    phone: '+1 415 555 0132',
    street: '500 Howard St',
    city: 'San Francisco',
    postalCode: '94105',
    country: 'USA',
  );

  static const PaymentMethodEntity card = PaymentMethodEntity(
    id: 'pm_1',
    type: PaymentMethodType.card,
    label: 'Visa',
    detail: '•••• 4242 · 08/28',
    isDefault: true,
  );

  static const DeliveryOptionEntity standard = DeliveryOptionEntity(
    id: 'standard',
    minDays: 3,
    maxDays: 5,
    fee: 6.99,
    freeOverThreshold: true,
  );

  static ProductEntity product(String id) => ProductEntity(
    id: id,
    name: 'Tee $id',
    brand: 'Tuku',
    categoryId: 'tees',
    gender: Gender.unisex,
    price: 20,
    rating: 4.5,
    reviewCount: 10,
    soldCount: 100,
    material: 'Cotton',
    description: '',
    highlights: const <String>[],
    sizes: const <String>['M'],
    colors: const <ProductColor>[],
    isNew: false,
    isBestSeller: false,
    isEco: false,
    createdAt: DateTime(2026),
  );

  static ProductPage page(
    List<String> ids, {
    int page = 1,
    int totalPages = 1,
  }) => ProductPage(
    items: ids.map(product).toList(),
    page: page,
    totalPages: totalPages,
    total: ids.length * totalPages,
  );

  static OrderEntity order({String id = 'o_1'}) => OrderEntity(
    id: id,
    code: 'TK-26$id',
    createdAt: DateTime(2026, 10, 1),
    status: OrderStatus.placed,
    items: const <OrderItemEntity>[],
    recipient: 'Alex Morgan',
    phone: '+1 415 555 0132',
    address: address.oneLine,
    paymentType: PaymentMethodType.card,
    paymentLabel: 'Visa',
    deliveryOptionId: 'standard',
    subtotal: 40,
    shippingFee: 6.99,
    discount: 0,
    estimatedDelivery: DateTime(2026, 10, 6),
    tracking: const <TrackingEventEntity>[],
  );
}

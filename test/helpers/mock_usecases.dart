import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockGetDemoAccountUsecase extends Mock implements GetDemoAccountUsecase {}

class MockRequestPasswordResetUsecase extends Mock
    implements RequestPasswordResetUsecase {}

class MockRegisterUsecase extends Mock implements RegisterUsecase {}

class MockUpdateProfileUsecase extends Mock implements UpdateProfileUsecase {}

class MockGetProductsUsecase extends Mock implements GetProductsUsecase {}

class MockGetCategoriesUsecase extends Mock implements GetCategoriesUsecase {}

class MockGetAddressesUsecase extends Mock implements GetAddressesUsecase {}

class MockGetPaymentMethodsUsecase extends Mock
    implements GetPaymentMethodsUsecase {}

class MockGetDeliveryOptionsUsecase extends Mock
    implements GetDeliveryOptionsUsecase {}

class MockPlaceOrderUsecase extends Mock implements PlaceOrderUsecase {}

class MockClearCartUsecase extends Mock implements ClearCartUsecase {}

class MockGetOrdersUsecase extends Mock implements GetOrdersUsecase {}

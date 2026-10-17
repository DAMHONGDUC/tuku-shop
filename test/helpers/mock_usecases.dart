import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBannersUsecase extends Mock implements GetBannersUsecase {}

class MockGetCategoriesUsecase extends Mock implements GetCategoriesUsecase {}

class MockGetNotificationsUsecase extends Mock
    implements GetNotificationsUsecase {}

class MockGetProfileSettingsUsecase extends Mock
    implements GetProfileSettingsUsecase {}

class MockGetRecommendProductUsecase extends Mock
    implements GetRecommendProductUsecase {}

class MockSearchProductsUsecase extends Mock implements SearchProductsUsecase {}

class MockGetMyOrderUsecase extends Mock implements GetMyOrderUsecase {}

class MockGetOrderDetailUsecase extends Mock implements GetOrderDetailUsecase {}

class MockGetProductDetailUsecase extends Mock
    implements GetProductDetailUsecase {}

class MockGetRelatedProductUsecase extends Mock
    implements GetRelatedProductUsecase {}

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

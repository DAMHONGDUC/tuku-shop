import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBannersUsecase extends Mock implements GetBannersUsecase {}

class MockGetCategoriesUsecase extends Mock implements GetCategoriesUsecase {}

class MockGetNotificationsUsecase extends Mock
    implements GetNotificationsUsecase {}

class MockGetProductDetailUsecase extends Mock
    implements GetProductDetailUsecase {}

class MockGetRelatedProductUsecase extends Mock
    implements GetRelatedProductUsecase {}

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

class MockGetProductsUsecase extends Mock implements GetProductsUsecase {}

class MockGetProductReviewsUsecase extends Mock
    implements GetProductReviewsUsecase {}

class MockGetProductsByIdsUsecase extends Mock
    implements GetProductsByIdsUsecase {}

class MockGetWishlistIdsUsecase extends Mock implements GetWishlistIdsUsecase {}

class MockWatchWishlistIdsUsecase extends Mock
    implements WatchWishlistIdsUsecase {}

class MockToggleWishlistUsecase extends Mock implements ToggleWishlistUsecase {}

class MockGetCartUsecase extends Mock implements GetCartUsecase {}

class MockWatchCartUsecase extends Mock implements WatchCartUsecase {}

class MockUpdateCartQuantityUsecase extends Mock
    implements UpdateCartQuantityUsecase {}

class MockRemoveCartLineUsecase extends Mock implements RemoveCartLineUsecase {}

class MockAddToCartUsecase extends Mock implements AddToCartUsecase {}

class MockMarkAllNotificationsReadUsecase extends Mock
    implements MarkAllNotificationsReadUsecase {}

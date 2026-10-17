import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/banner/data/data_sources/banner_remote_data_source.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';
import 'package:tuku_shop/src/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:tuku_shop/src/features/category/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:tuku_shop/src/features/product/data/data_sources/search_history_local_data_source.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class MockBannerRepository extends Mock implements BannerRepository {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

class MockProductRepository extends Mock implements ProductRepository {}

class MockOrderRepository extends Mock implements OrderRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

class MockCategoryRemoteDataSource extends Mock
    implements CategoryRemoteDataSource {}

class MockBannerRemoteDataSource extends Mock
    implements BannerRemoteDataSource {}

class MockNotificationRemoteDataSource extends Mock
    implements NotificationRemoteDataSource {}

class MockOrderRemoteDataSource extends Mock implements OrderRemoteDataSource {}

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockSearchHistoryLocalDataSource extends Mock
    implements SearchHistoryLocalDataSource {}

class MockCartRepository extends Mock implements CartRepository {}

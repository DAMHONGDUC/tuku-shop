import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

abstract final class AuthMock {
  static const String demoEmail = 'demo@tukushop.com';
  static const String demoPassword = 'Tuku@2026';

  static const UserModel demoUser = UserModel(
    id: 'u_demo',
    fullName: 'Alex Morgan',
    email: demoEmail,
    phone: '+1 (415) 555-0132',
    memberSince: '2024-03-12',
    points: 2480,
    avatar: AppAssets.userAvatar,
  );
}

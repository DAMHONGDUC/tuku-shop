import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';
import 'package:tuku_shop/src/features/auth/domain/entities/demo_account.dart';

/// The demo account: signed in on first launch, and accepted by the mock
/// login.
class AuthMock {
  static const defaultUser = UserModel(
    id: 'user-demo-001',
    fullName: 'Tuku Demo',
    email: DemoAccount.email,
    phone: '+1 202 555 0147',
    avatarUrl: '',
  );
}

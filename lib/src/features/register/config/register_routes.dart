import 'package:system_design/index.dart';

class RegisterRoutes {
  static const SdRouterV5 register = SdRouterV5(
    name: 'register',
    path: '/register',
    fullPath: '/register',
  );

  static final SdRouterV5 registerOtp = SdRouterV5(
    name: 'register-otp',
    path: 'register-otp',
    fullPath: '${register.fullPath}/register-otp',
  );
}

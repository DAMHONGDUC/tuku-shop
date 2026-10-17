import 'package:system_design/index.dart';

class LoginRoutes {
  static const SdRouterV5 login = SdRouterV5(
    name: 'login',
    path: '/login',
    fullPath: '/login',
  );
  static final SdRouterV5 loginOtp = SdRouterV5(
    name: 'login-otp',
    path: 'login-otp',
    fullPath: '${login.fullPath}/login-otp',
  );
}

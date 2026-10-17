import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/core/l10n/app_localizations.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

import 'app_router.dart';
import 'state/cart_controller.dart';
import 'state/session_controller.dart';
import 'state/settings_controller.dart';
import 'state/unread_notifications_controller.dart';
import 'state/wishlist_controller.dart';

class TukuApp extends StatelessWidget {
  const TukuApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: <BlocProvider<dynamic>>[
      BlocProvider<SessionController>.value(value: getIt<SessionController>()),
      BlocProvider<SettingsController>.value(value: getIt<SettingsController>()),
      BlocProvider<CartController>.value(value: getIt<CartController>()),
      BlocProvider<WishlistController>.value(value: getIt<WishlistController>()),
      BlocProvider<UnreadNotificationsController>.value(
        value: getIt<UnreadNotificationsController>(),
      ),
    ],
    child: BlocBuilder<SettingsController, AppSettings>(
      builder: (BuildContext context, AppSettings _) {
        final SettingsController settings = context.read<SettingsController>();
        final Size window = MediaQueryData.fromView(View.of(context)).size;

        return ScreenUtilInit(
          designSize: SdScreenScale.designSize(
            window,
            const Size(AppConstants.designWidth, AppConstants.designHeight),
          ),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? _) => MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            themeAnimationDuration: SdMotionV5.slow,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
          ),
        );
      },
    ),
  );
}

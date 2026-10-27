import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/core/l10n/app_localizations.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/cart/presentation/cart/cart_controller.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_badge/chat_unread_controller.dart';
import 'package:tuku_shop/src/features/notification/presentation/notification_badge/notification_badge_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';
import 'package:tuku_shop/src/features/settings/presentation/locale_controller.dart';

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({
    super.key,
    required this.theme,
    required this.darkTheme,
  });

  final ThemeData theme;
  final ThemeData darkTheme;

  @override
  Widget build(BuildContext context) {
    // App-wide state that tabs and pushed screens share.
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavoritesController>()..load()),
        BlocProvider.value(value: getIt<CartController>()..load()),
        BlocProvider.value(value: getIt<NotificationBadgeController>()..load()),
        BlocProvider.value(value: getIt<ChatUnreadController>()..load()),
        BlocProvider.value(value: getIt<LocaleController>()..load()),
      ],
      child: BlocBuilder<LocaleController, Locale?>(
        builder: (context, locale) => MaterialApp.router(
          locale: locale,
          theme: theme,
          darkTheme: darkTheme,
          routerConfig: kAppRouter,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // Status bar icons follow the theme; screens with a colored header
          // (splash) set their own. Every app bar's cart badge reads the
          // count from [CartCountScope].
          builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: Theme.of(context).brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: BlocSelector<CartController, CartState, int>(
              selector: (state) => state.itemCount,
              builder: (context, count) =>
                  CartCountScope(count: count, child: child!),
            ),
          ),
        ),
      ),
    );
  }
}

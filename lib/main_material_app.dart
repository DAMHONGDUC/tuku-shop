import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/core/l10n/app_localizations.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/presentation/favorites/favorites_controller.dart';

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
      ],
      child: MaterialApp.router(
        theme: theme,
        darkTheme: darkTheme,
        routerConfig: kAppRouter,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // Status bar icons follow the theme; screens with a colored header
        // (splash) set their own.
        builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context).brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: child!,
        ),
      ),
    );
  }
}

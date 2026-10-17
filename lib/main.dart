import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:tuku_shop/main_material_app.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialisation();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(TukuShopApp(savedThemeMode: savedThemeMode));
}

class TukuShopApp extends StatelessWidget {
  const TukuShopApp({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.buildLightTheme(),
      dark: AppTheme.buildDarkTheme(),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) =>
          MainMaterialApp(theme: theme, darkTheme: darkTheme),
    );
  }
}

Future<void> initialisation() async {
  try {
    // di
    Injector.config();

    // bloc observer
    Bloc.observer = SdBlocObserverV5();
  } catch (e, stackTrace) {
    SdLogV5.e('Initialization Error: $e', stackTrace);
  }
}

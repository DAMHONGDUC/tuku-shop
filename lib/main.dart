import 'package:firebase_core/firebase_core.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/settings_controller.dart';
import 'package:tuku_shop/src/app/tuku_app.dart';
import 'package:tuku_shop/src/di/injector.dart';

Future<void> main() => SdBootstrap.run(
  logTag: 'TukuShop',
  steps: <SdBootstrapStep>[
    // Optional in the demo: without GoogleService files it fails, is logged,
    // and the app carries on — nothing reads Firebase yet.
    const SdBootstrapStep(name: 'firebase', run: Firebase.initializeApp),
    const SdBootstrapStep(name: 'dependencies', run: Injector.config),
    SdBootstrapStep(
      name: 'settings',
      run: () => getIt<SettingsController>().load(),
    ),
  ],
  builder: () => const TukuApp(),
);

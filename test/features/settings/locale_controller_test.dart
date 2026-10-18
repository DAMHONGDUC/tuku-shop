import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/features/settings/data/settings_repository_impl.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';
import 'package:tuku_shop/src/features/settings/presentation/locale_controller.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  LocaleController build() {
    final repo = SettingsRepositoryImpl();
    return LocaleController(GetLanguageUsecase(repo), SetLanguageUsecase(repo));
  }

  test('defaults to the device language', () async {
    final c = build();
    await c.load();
    expect(c.state, isNull);
  });

  test('a picked language survives a relaunch; system clears it', () async {
    await build().select('vi');
    final relaunched = build();
    await relaunched.load();
    expect(relaunched.state, const Locale('vi'));

    await relaunched.select(null);
    final again = build();
    await again.load();
    expect(again.state, isNull);
  });

  test('an unsupported language is rejected and rolled back', () async {
    final c = build();
    await c.select('fr');
    expect(c.state, isNull);
  });
}

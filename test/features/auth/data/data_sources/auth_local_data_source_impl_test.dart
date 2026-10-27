import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:tuku_shop/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:tuku_shop/src/features/auth/data/mock/auth_mock.dart';
import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  // A new instance over the same store stands in for an app relaunch.
  AuthLocalDataSourceImpl launch() =>
      AuthLocalDataSourceImpl(prefs: SharedPreferencesAsync());

  test('first launch saves and returns the default user', () async {
    final user = await launch().getSessionUser();

    expect(user?.email, AuthMock.defaultUser.email);
    expect(user?.id, AuthMock.defaultUser.id);
  });

  test('after logout, the next launch stays signed out', () async {
    final dataSource = launch();
    await dataSource.getSessionUser();
    await dataSource.clearSession();

    expect(await launch().getSessionUser(), isNull);
  });

  test('a saved user is returned on the next launch', () async {
    final dataSource = launch();
    await dataSource.getSessionUser();
    await dataSource.saveSessionUser(
      const UserModel(id: 'u-2', email: 'other@example.com'),
    );

    final user = await launch().getSessionUser();

    expect(user?.id, 'u-2');
    expect(user?.email, 'other@example.com');
  });
}

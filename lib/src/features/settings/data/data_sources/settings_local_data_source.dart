import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

class SettingsLocalDataSource {
  const SettingsLocalDataSource(this.preferences);

  final SharedPreferences preferences;

  static const String _theme = 'settings.theme';
  static const String _language = 'settings.language';
  static const String _onboarding = 'settings.onboardingSeen';
  static const String _push = 'settings.push';
  static const String _email = 'settings.email';

  AppSettings read() {
    const AppSettings defaults = AppSettings();

    return AppSettings(
      theme: ThemePreference.values.firstWhere(
        (ThemePreference e) => e.name == preferences.getString(_theme),
        orElse: () => defaults.theme,
      ),
      languageCode: preferences.getString(_language) ?? defaults.languageCode,
      onboardingSeen:
          preferences.getBool(_onboarding) ?? defaults.onboardingSeen,
      pushNotifications:
          preferences.getBool(_push) ?? defaults.pushNotifications,
      emailUpdates: preferences.getBool(_email) ?? defaults.emailUpdates,
    );
  }

  Future<void> write(AppSettings settings) async {
    await preferences.setString(_theme, settings.theme.name);
    await preferences.setString(_language, settings.languageCode);
    await preferences.setBool(_onboarding, settings.onboardingSeen);
    await preferences.setBool(_push, settings.pushNotifications);
    await preferences.setBool(_email, settings.emailUpdates);
  }
}

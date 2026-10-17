import 'package:equatable/equatable.dart';

enum ThemePreference { system, light, dark }

class AppSettings extends Equatable {
  const AppSettings({
    this.theme = ThemePreference.light,
    this.languageCode = 'en',
    this.onboardingSeen = false,
    this.pushNotifications = true,
    this.emailUpdates = false,
  });

  final ThemePreference theme;
  final String languageCode;
  final bool onboardingSeen;
  final bool pushNotifications;
  final bool emailUpdates;

  AppSettings copyWith({
    ThemePreference? theme,
    String? languageCode,
    bool? onboardingSeen,
    bool? pushNotifications,
    bool? emailUpdates,
  }) => AppSettings(
    theme: theme ?? this.theme,
    languageCode: languageCode ?? this.languageCode,
    onboardingSeen: onboardingSeen ?? this.onboardingSeen,
    pushNotifications: pushNotifications ?? this.pushNotifications,
    emailUpdates: emailUpdates ?? this.emailUpdates,
  );

  @override
  List<Object> get props => <Object>[
    theme,
    languageCode,
    onboardingSeen,
    pushNotifications,
    emailUpdates,
  ];
}

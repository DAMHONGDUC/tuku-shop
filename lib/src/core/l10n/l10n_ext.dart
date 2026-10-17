import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;

  /// The UI language code, for date formatting.
  String get localeName => Localizations.localeOf(this).toLanguageTag();
}

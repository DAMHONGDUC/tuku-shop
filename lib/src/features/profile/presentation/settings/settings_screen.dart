import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/settings_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

/// Theme, language and notification preferences. Reads and writes the
/// app-wide [SettingsController], so a change repaints the whole app at once.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const List<String> _languages = <String>['en', 'vi'];

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<SettingsController, AppSettings>(
    builder: (BuildContext context, AppSettings settings) {
      final SettingsController controller = context.read<SettingsController>();

      final List<Widget> children = <Widget>[
        SdSectionHeaderV5(title: context.loc.settings_appearance),
        for (final ThemePreference theme in ThemePreference.values) ...<Widget>[
          SdSelectableCardV5(
            icon: _themeIcon(theme),
            title: _themeLabel(context, theme),
            selected: settings.theme == theme,
            onSelected: () => controller.setTheme(theme),
          ),
          SizedBox(height: SdSpacingConstant.h8),
        ],
        SizedBox(height: SdContentPaddingV5.sectionGap - SdSpacingConstant.h8),
        SdSectionHeaderV5(title: context.loc.settings_language),
        for (final String code in _languages) ...<Widget>[
          SdSelectableCardV5(
            icon: Symbols.translate_rounded,
            title: code == 'vi'
                ? context.loc.settings_language_vi
                : context.loc.settings_language_en,
            selected: settings.languageCode == code,
            onSelected: () => controller.setLanguage(code),
          ),
          SizedBox(height: SdSpacingConstant.h8),
        ],
        SizedBox(height: SdContentPaddingV5.sectionGap - SdSpacingConstant.h8),
        SdSectionHeaderV5(title: context.loc.settings_notifications),
        SdListTileV5(
          icon: Symbols.notifications_active_rounded,
          title: context.loc.settings_push,
          subtitle: context.loc.settings_push_hint,
          trailing: SdSwitchV5(
            value: settings.pushNotifications,
            semanticLabel: context.loc.settings_push,
            onChanged: (bool value) =>
                controller.update(settings.copyWith(pushNotifications: value)),
          ),
        ),
        SdListTileV5(
          icon: Symbols.mail_rounded,
          title: context.loc.settings_email,
          subtitle: context.loc.settings_email_hint,
          trailing: SdSwitchV5(
            value: settings.emailUpdates,
            semanticLabel: context.loc.settings_email,
            onChanged: (bool value) =>
                controller.update(settings.copyWith(emailUpdates: value)),
          ),
        ),
        SizedBox(height: SdContentPaddingV5.sectionGap),
        SdSectionHeaderV5(title: context.loc.settings_about),
        SdListTileV5(
          icon: Symbols.info_rounded,
          title: context.loc.settings_version,
          trailing: Text(
            AppConstants.appVersion,
            style: context.textTheme5.bodyMedium!.muted5(context),
          ),
        ),
      ];

      return SdScaffoldV5(
        appBar: SdAppBarV5(title: context.loc.settings_title),
        body: ListView(
          padding: SdContentPaddingV5.gutter.copyWith(
            top: SdSpacingConstant.h8,
            bottom: SdContentPaddingV5.detailBottom(context),
          ),
          children: <Widget>[
            for (final (int i, Widget child) in children.indexed)
              SdFadeInV5(index: i, child: child),
          ],
        ),
      );
    },
  );

  static IconData _themeIcon(ThemePreference theme) => switch (theme) {
    ThemePreference.light => Symbols.light_mode_rounded,
    ThemePreference.dark => Symbols.dark_mode_rounded,
    ThemePreference.system => Symbols.brightness_auto_rounded,
  };

  static String _themeLabel(BuildContext context, ThemePreference theme) =>
      switch (theme) {
        ThemePreference.light => context.loc.settings_theme_light,
        ThemePreference.dark => context.loc.settings_theme_dark,
        ThemePreference.system => context.loc.settings_theme_system,
      };
}

import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/core/resources/custom_theme_ext/app_color_theme_ext.dart';

enum AppToastType { success, error, info }

/// The app's toast: a floating card in the page's own surface color, so it
/// reads as part of the screen in light and dark mode, with a status icon.
///
/// Take it with [AppToast.of] before an `await` when the widget that asked
/// may be gone by the time the toast shows (a dismissed cart line).
class AppToast {
  AppToast._(this._messenger, this._colors);

  factory AppToast.of(BuildContext context) =>
      AppToast._(ScaffoldMessenger.of(context), context.colorTheme);

  final ScaffoldMessengerState _messenger;
  final AppColorThemeExt _colors;

  void show(
    String message, {
    AppToastType type = AppToastType.info,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final (icon, tint) = switch (type) {
      AppToastType.success => (Icons.check_circle_rounded, _colors.success),
      AppToastType.error => (Icons.error_outline_rounded, _colors.sale),
      AppToastType.info => (Icons.info_outline_rounded, _colors.primary),
    };

    _messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SdIconV5(iconData: icon, iconSize: SdSpacingV5.s20, color: tint),
              SdHorizontalSpacingV5(value: SdSpacingV5.s12),
              Expanded(
                child: Text(
                  message,
                  style: SdTextStyleV5.body14().wColor(_colors.textDefault),
                ),
              ),
            ],
          ),
          // An action would otherwise keep it up until tapped.
          persist: false,
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                ),
        ),
      );
  }
}

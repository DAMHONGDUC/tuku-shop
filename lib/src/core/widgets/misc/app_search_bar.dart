import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The one search pill: Home shows it read-only ([onTap] opens Search),
/// Search edits it. Same height, fill, radius and icons on both. Filters
/// live in the app bar ([FilterActionButton]), not in the pill.
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.hintText,
    this.controller,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
  });

  final String hintText;
  final TextEditingController? controller;

  /// Set to make the bar read-only and tappable (Home).
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Shown as a clear button while there is text.
  final VoidCallback? onClear;

  final bool autofocus;

  static const double height = SdSpacingV5.s44;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final pill = BorderRadius.circular(SdSpacingV5.s100);

    Widget trailing(bool hasText) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasText && onClear != null)
          AppIconButton(
            icon: Icons.close_rounded,
            label: MaterialLocalizations.of(context).deleteButtonTooltip,
            iconColor: colors.iconSecondary,
            onTap: onClear,
          ),
      ],
    );

    Widget field(bool hasText) => SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        readOnly: onTap != null,
        onTap: onTap,
        autofocus: autofocus,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        style: SdTextStyleV5.body14().wColor(colors.textDefault),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: SdTextStyleV5.body14().wColor(colors.textSubTitle),
          filled: true,
          fillColor: colors.cardDefault,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: SdSpacingV5.s12),
          prefixIcon: SdIconV5(
            iconData: Icons.search_rounded,
            iconSize: SdSpacingV5.s20,
            color: colors.iconSecondary,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: SdSpacingV5.s44,
            minHeight: height,
          ),
          suffixIcon: hasText && onClear != null ? trailing(hasText) : null,
          suffixIconConstraints: const BoxConstraints(minHeight: height),
          border: OutlineInputBorder(
            borderRadius: pill,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: pill,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: pill,
            borderSide: BorderSide(
              color: onTap != null ? SdColorsV5.transparent : colors.primary,
            ),
          ),
        ),
      ),
    );

    final text = controller;
    if (text == null) return field(false);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: text,
      builder: (_, value, _) => field(value.text.isNotEmpty),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

final _kFieldRadius = SdSpacingV5.s12;

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.errorText,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final String? errorText;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(_kFieldRadius),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: SdTextStyleV5.body14().wMedium().copyWith(
            color: colors.textDefault,
          ),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          autocorrect: false,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorColor: colors.primary,
          style: SdTextStyleV5.body14().copyWith(color: colors.textDefault),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: SdTextStyleV5.body14().copyWith(
              color: colors.textSubTitle,
            ),
            errorText: errorText,
            filled: true,
            fillColor: colors.cardDefault,
            prefixIcon: SdIconV5(
              iconData: prefixIcon,
              iconSize: SdSpacingV5.s20,
              color: colors.iconSecondary,
            ),
            suffixIcon: suffix,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SdSpacingV5.s16,
              vertical: SdSpacingV5.s14,
            ),
            enabledBorder: _border(colors.borderDefault),
            focusedBorder: _border(colors.primary),
            errorBorder: _border(context.colorTheme.sale),
            focusedErrorBorder: _border(context.colorTheme.sale),
          ),
        ),
      ],
    );
  }
}

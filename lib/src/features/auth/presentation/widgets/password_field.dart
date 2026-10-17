import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A password field with a show / hide eye.
class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.label,
    required this.controller,
    this.errorText,
    this.helperText,
    this.onSubmitted,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? errorText;
  final String? helperText;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final TextInputAction textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) => SdTextFieldV5(
    label: widget.label,
    controller: widget.controller,
    obscureText: _hidden,
    prefixIcon: Symbols.lock_rounded,
    errorText: widget.errorText,
    helperText: widget.helperText,
    textInputAction: widget.textInputAction,
    onSubmitted: widget.onSubmitted,
    onChanged: widget.onChanged,
    autofillHints: const <String>[AutofillHints.password],
    suffix: SdIconButtonV5(
      icon: _hidden
          ? Symbols.visibility_rounded
          : Symbols.visibility_off_rounded,
      tooltip: _hidden ? context.loc.password_show : context.loc.password_hide,
      size: SdSpacingConstant.r40,
      color: context.sdTheme5.textTertiary,
      onPressed: () => setState(() => _hidden = !_hidden),
    ),
  );
}

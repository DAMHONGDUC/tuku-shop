import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../login_controller.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({required this.initialEmail, super.key});

  final String initialEmail;

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  late final TextEditingController _email = TextEditingController(
    text: widget.initialEmail,
  );
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() {
      _busy = true;
      _error = null;
    });

    final bool sent = await context
        .read<LoginController>()
        .requestPasswordReset(_email.text);

    if (!mounted) return;

    if (!sent) {
      setState(() {
        _busy = false;
        _error = context.loc.validation_email;
      });
      return;
    }

    Navigator.of(context).pop();
    SdSnackBarUtilsV5.success(
      context,
      context.loc.forgot_sent(_email.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) => SdBottomSheetV5(
    title: context.loc.forgot_title,
    closeTooltip: context.loc.action_close,
    footer: SdButtonV5(
      variant: SdButtonVariantV5.primary,
      label: context.loc.forgot_submit,
      expand: true,
      busy: _busy,
      onPressed: _send,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          context.loc.forgot_body,
          style: context.textTheme5.bodyMedium!.muted5(context),
        ),
        SizedBox(height: SdSpacingConstant.h16),
        SdTextFieldV5(
          label: context.loc.field_email,
          controller: _email,
          prefixIcon: Symbols.mail_rounded,
          keyboardType: TextInputType.emailAddress,
          errorText: _error,
        ),
      ],
    ),
  );
}

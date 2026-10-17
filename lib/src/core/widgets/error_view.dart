import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';

import '../l10n/l10n_ext.dart';

/// What a screen shows when its load failed: a calm message and a retry.
class ErrorView extends StatelessWidget {
  const ErrorView({required this.onRetry, this.message, super.key});

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) => SdEmptyStateV5(
    icon: Symbols.cloud_off_rounded,
    title: context.loc.error_title,
    message: message ?? context.loc.error_message,
    action: SdButtonV5(
      variant: SdButtonVariantV5.outlined,
      label: context.loc.action_retry,
      icon: Symbols.refresh_rounded,
      onPressed: onRetry,
    ),
  );
}

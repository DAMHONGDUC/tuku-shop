import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

/// Enter a code, or show the one applied with a way to take it off.
class PromoCodeField extends StatefulWidget {
  const PromoCodeField({required this.promo, super.key});

  final PromoEntity? promo;

  @override
  State<PromoCodeField> createState() => _PromoCodeFieldState();
}

class _PromoCodeFieldState extends State<PromoCodeField> {
  final TextEditingController _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _apply() async {
    if (_code.text.trim().isEmpty) return;

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });

    final Failure? failure = await context.read<CartController>().applyPromo(_code.text);

    if (!mounted) return;

    setState(() {
      _busy = false;
      _error = switch (failure) {
        null => null,
        ValidationFailure(code: FailureCodes.promoMinimum) =>
          context.loc.promo_error_minimum,
        ValidationFailure() => context.loc.promo_error_invalid,
        _ => context.loc.error_message,
      };
    });

    if (failure == null) {
      _code.clear();
      SdSnackBarUtilsV5.success(context, context.loc.promo_applied);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: SdMotionV5.of(context, SdMotionV5.normal),
    child: widget.promo != null
        ? SdCardV5(
            key: const ValueKey<String>('applied'),
            layer: SdCardLayerV5.outlined,
            borderColor: context.sdTheme5.success,
            padding: EdgeInsets.symmetric(
              horizontal: SdSpacingConstant.w14,
              vertical: SdSpacingConstant.h8,
            ),
            child: Row(
              children: <Widget>[
                SdIconV5(Symbols.sell_rounded, color: context.sdTheme5.success),
                SizedBox(width: SdSpacingConstant.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.promo!.code, style: context.textTheme5.labelLarge!.bold5),
                      Text(
                        widget.promo!.freeShipping
                            ? context.loc.promo_free_shipping
                            : context.loc.promo_percent_off((widget.promo!.percentOff * 100).round()),
                        style: context.textTheme5.bodySmall!.muted5(context),
                      ),
                    ],
                  ),
                ),
                SdButtonV5(
                  variant: SdButtonVariantV5.text,
                  size: SdButtonSizeV5.small,
                  label: context.loc.action_remove,
                  onPressed: context.read<CartController>().removePromo,
                ),
              ],
            ),
          )
        : Column(
            key: const ValueKey<String>('field'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: SdTextFieldV5(
                      label: context.loc.promo_label,
                      hint: context.loc.promo_hint,
                      controller: _code,
                      prefixIcon: Symbols.confirmation_number_rounded,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (String _) => _apply(),
                    ),
                  ),
                  SizedBox(width: SdSpacingConstant.w8),
                  SdButtonV5(
                    variant: SdButtonVariantV5.primary,
                    label: context.loc.action_apply,
                    busy: _busy,
                    onPressed: _apply,
                  ),
                ],
              ),
              if (_error != null)
                Padding(
                  padding: EdgeInsets.only(top: SdSpacingConstant.h6, left: SdSpacingConstant.w4),
                  child: Text(
                    _error!,
                    style: context.textTheme5.bodySmall!.copyWith(
                      color: context.sdTheme5.danger,
                    ),
                  ),
                ),
            ],
          ),
  );
}

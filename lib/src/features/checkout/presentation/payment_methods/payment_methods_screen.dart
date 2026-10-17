import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

import '../checkout/components/checkout_labels.dart';
import 'payment_methods_controller.dart';

/// The wallet: the default card drawn as a card, then every method to pick
/// a new default from.
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<PaymentMethodsController>(
    create: (BuildContext _) => getIt<PaymentMethodsController>()..load(),
    child: SdScaffoldV5(
      appBar: SdAppBarV5(title: context.loc.payment_title),
      body: BlocBuilder<PaymentMethodsController, PaymentMethodsState>(
        builder: (BuildContext context, PaymentMethodsState state) {
          final PaymentMethodEntity? card = state.methods.firstWhereOrNull(
            (PaymentMethodEntity m) => m.isDefault && m.type == PaymentMethodType.card,
          );

          return FadeSwitcher(
            child: state.status != LoadStatus.success
                ? const Center(child: SdLoadingV5())
                : ListView(
                    padding: SdContentPaddingV5.gutter.copyWith(
                      top: SdSpacingConstant.h8,
                      bottom: SdContentPaddingV5.detailBottom(context),
                    ),
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: SdMotionV5.of(context, SdMotionV5.slow),
                        child: card == null
                            ? const SizedBox.shrink()
                            : _CardArt(key: ValueKey<String>(card.id), method: card),
                      ),
                      SizedBox(height: SdSpacingConstant.h24),
                      Text(context.loc.payment_methods, style: context.textTheme5.titleMedium),
                      SizedBox(height: SdSpacingConstant.h12),
                      for (final PaymentMethodEntity m in state.methods)
                        Padding(
                          padding: EdgeInsets.only(bottom: SdSpacingConstant.h10),
                          child: SdSelectableCardV5(
                            title: context.paymentName(m),
                            subtitle: m.detail,
                            icon: paymentIcon(m.type),
                            selected: m.isDefault,
                            trailing: m.isDefault
                                ? SdBadgeV5(label: context.loc.address_default, tone: SdBadgeToneV5.inverse)
                                : null,
                            onSelected: () =>
                                context.read<PaymentMethodsController>().makeDefault(m.id),
                          ),
                        ),
                      SizedBox(height: SdSpacingConstant.h8),
                      SdButtonV5(
                        variant: SdButtonVariantV5.outlined,
                        label: context.loc.payment_add_card,
                        icon: Symbols.add_card_rounded,
                        expand: true,
                        onPressed: () =>
                            SdSnackBarUtilsV5.info(context, context.loc.payment_add_demo),
                      ),
                    ],
                  ),
          );
        },
      ),
    ),
  );
}

class _CardArt extends StatelessWidget {
  const _CardArt({required this.method, super.key});

  final PaymentMethodEntity method;

  @override
  Widget build(BuildContext context) {
    final List<String> parts = (method.detail ?? '').split(' · ');

    return AspectRatio(
      aspectRatio: 1.586,
      child: Container(
        padding: EdgeInsets.all(SdSpacingConstant.w20),
        decoration: BoxDecoration(
          borderRadius: SdRadiusV5.cardAll,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFF1C1C1E), Color(0xFF3A3530), Color(0xFF7A5C3E)],
          ),
          boxShadow: SdElevationV5.high(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${AppConstants.wordmark}.',
                  style: context.textTheme5.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Spacer(),
                Text(
                  method.label.toUpperCase(),
                  style: context.textTheme5.titleMedium!.bold5.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const SdIconV5(Symbols.contactless_rounded, color: Colors.white70),
            SizedBox(height: SdSpacingConstant.h12),
            Text(
              '••••  ••••  ••••  ${parts.first.replaceAll('•', '').trim()}',
              style: context.textTheme5.titleLarge!.tabular5.copyWith(
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: SdSpacingConstant.h8),
            Text(
              parts.length > 1 ? parts[1] : '',
              style: context.textTheme5.labelMedium!.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

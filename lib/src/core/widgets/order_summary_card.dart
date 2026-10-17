import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import '../l10n/l10n_ext.dart';
import '../utils/formatters.dart';

/// Subtotal, discount, shipping and total — shared by the bag, checkout and
/// the order page, so the three always add up the same way.
class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.total,
    this.savings = 0,
    this.promoCode,
    super.key,
  });

  final double subtotal;
  final double discount;
  final double shipping;
  final double total;
  final double savings;
  final String? promoCode;

  @override
  Widget build(BuildContext context) => SdCardV5(
    child: Column(
      children: <Widget>[
        SummaryRow(
          label: context.loc.summary_subtotal,
          value: Formatters.currency(subtotal),
        ),
        if (discount > 0)
          SummaryRow(
            label: promoCode == null
                ? context.loc.summary_discount
                : '${context.loc.summary_discount} ($promoCode)',
            value: '-${Formatters.currency(discount)}',
            valueColor: context.sdTheme5.success,
          ),
        SummaryRow(
          label: context.loc.summary_shipping,
          value: shipping == 0
              ? context.loc.summary_free
              : Formatters.currency(shipping),
          valueColor: shipping == 0 ? context.sdTheme5.success : null,
        ),
        SdDividerV5(spacing: SdSpacingConstant.h24),
        SummaryRow(
          label: context.loc.summary_total,
          value: Formatters.currency(total),
          emphasized: true,
        ),
        if (savings > 0) ...<Widget>[
          SizedBox(height: SdSpacingConstant.h8),
          Align(
            alignment: Alignment.centerRight,
            child: SdBadgeV5(
              label: context.loc.summary_savings(
                Formatters.currency(savings + discount),
              ),
              tone: SdBadgeToneV5.success,
            ),
          ),
        ],
      ],
    ),
  );
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.emphasized = false,
    super.key,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = emphasized
        ? context.textTheme5.titleLarge!
        : context.textTheme5.bodyMedium!.muted5(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h4),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label, style: style)),
          AnimatedSwitcher(
            duration: SdMotionV5.of(context, SdMotionV5.fast),
            child: Text(
              value,
              key: ValueKey<String>(value),
              style:
                  (emphasized
                          ? style
                          : context.textTheme5.bodyMedium!.semiBold5)
                      .tabular5
                      .copyWith(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }
}

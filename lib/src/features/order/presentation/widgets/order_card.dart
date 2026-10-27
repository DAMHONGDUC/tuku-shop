import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import 'order_status_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});

  final OrderEntity order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final first = order.items.first;
    final more = order.items.length - 1;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Material(
      color: colors.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
        child: Padding(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '#${order.id}',
                    style: SdTextStyleV5.body14().wSemiBold().wColor(
                      colors.textDefault,
                    ),
                  ),
                  SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                  Text(
                    DateFormat.yMMMd(locale).format(order.createdAt),
                    style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                  ),
                  const Spacer(),
                  TagChip(
                    label: order.status.label(context),
                    color: order.status.tone(context),
                  ),
                ],
              ),
              SdVerticalSpacingV5(value: SdSpacingV5.s12),
              Row(
                children: [
                  CatalogImage(
                    path: first.imageUrl,
                    width: 56,
                    height: 70,
                    borderRadius: SdSpacingV5.s8,
                  ),
                  SdHorizontalSpacingV5(value: SdSpacingV5.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          first.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: SdTextStyleV5.body14().wColor(
                            colors.textDefault,
                          ),
                        ),
                        Text(
                          more > 0
                              ? context.loc.order_more_items(more)
                              : '${first.colorName} · ${first.size} · ×${first.quantity}',
                          style: SdTextStyleV5.body12().wColor(
                            colors.textSubTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SdVerticalSpacingV5(value: SdSpacingV5.s12),
              Row(
                children: [
                  Text(
                    context.loc.order_items_total(order.itemCount),
                    style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                  ),
                  const Spacer(),
                  PriceText(
                    price: order.total,
                    style: SdTextStyleV5.heading16(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

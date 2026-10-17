import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

import '../../widgets/order_labels.dart';

/// An order in the list: number and status, stacked thumbnails, date and
/// total.
class OrderCard extends StatelessWidget {
  const OrderCard({required this.order, required this.onTap, super.key});

  final OrderEntity order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SdCardV5(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(order.code, style: context.textTheme5.titleSmall!.tabular5),
            ),
            SdBadgeV5(
              label: context.orderStatusLabel(order.status),
              tone: orderStatusTone(order.status),
              icon: orderStatusIcon(order.status),
            ),
          ],
        ),
        SizedBox(height: SdSpacingConstant.h4),
        Text(
          Formatters.dateTime(order.createdAt, context.localeName),
          style: context.textTheme5.bodySmall!.faint5(context),
        ),
        SizedBox(height: SdSpacingConstant.h14),
        Row(
          children: <Widget>[
            for (final OrderItemEntity item in order.items.take(3))
              Padding(
                padding: EdgeInsets.only(right: SdSpacingConstant.w8),
                child: SizedBox(
                  width: SdSpacingConstant.w56,
                  height: SdSpacingConstant.w56 / 0.8,
                  child: AppImage(item.image, borderRadius: SdRadiusV5.thumbnailAll),
                ),
              ),
            if (order.items.length > 3)
              Container(
                width: SdSpacingConstant.w56,
                height: SdSpacingConstant.w56 / 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.sdTheme5.surfaceSunken,
                  borderRadius: SdRadiusV5.thumbnailAll,
                ),
                child: Text('+${order.items.length - 3}', style: context.textTheme5.labelLarge),
              ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  context.loc.checkout_items(order.itemCount),
                  style: context.textTheme5.labelMedium!.muted5(context),
                ),
                SizedBox(height: SdSpacingConstant.h2),
                Text(
                  Formatters.currency(order.total),
                  style: context.textTheme5.titleMedium!.tabular5,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

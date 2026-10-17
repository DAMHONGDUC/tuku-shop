import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return SdInkWellV5(
      onTap: onTap,
      borderRadius: 0,
      containerBg: isUnread
          ? context.colorTheme.primary.withValues(alpha: 0.05)
          : context.colorTheme.cardDefault,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SdIconV5(
                  iconData: notification.type.iconData,
                  iconSize: SdSpacingV5.s28,
                  color: context.colorTheme.iconDefault,
                ),
                SdHorizontalSpacingV5(),
                Expanded(
                  child: _InfoSectio(
                    name: notification.title,
                    description: notification.body,
                    createdAt: notification.timestamp,
                  ),
                ),
              ],
            ),
          ),
          SdHorizontalSpacingV5(xRatio: 0.5),
          SdIconV5(
            iconData: Icons.chevron_right,
            iconSize: SdSpacingV5.s20,
            color: context.colorTheme.iconSecondary,
          ),
        ],
      ),
    );
  }
}

class _InfoSectio extends StatelessWidget {
  const _InfoSectio({
    required this.name,
    required this.description,
    required this.createdAt,
  });
  final String name;
  final String description;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: SdTextStyleV5.heading14(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SdVerticalSpacingV5(xRatio: 0.25),
        Text(
          description,
          style: SdTextStyleV5.body12().wColor(context.colorTheme.textSubTitle),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SdVerticalSpacingV5(xRatio: 0.25),
        Text(
          SdDateTimeHelperV5.dateTimeToHHMMDDMMYY(createdAt),
          style: SdTextStyleV5.body12().copyWith(
            color: context.colorTheme.textSubTitle,
          ),
        ),
      ],
    );
  }
}

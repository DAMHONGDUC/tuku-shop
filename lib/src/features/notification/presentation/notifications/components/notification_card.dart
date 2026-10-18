import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

/// One notification: a tinted type icon, the message, its age and an unread
/// dot.
class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;

  const NotificationCard({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final isUnread = !notification.isRead;
    final tint = _tint(context, notification.type);

    return Material(
      color: isUnread ? colors.primarySoft : colors.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
        child: Padding(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SdSpacingV5.s44,
                height: SdSpacingV5.s44,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SdIconV5(
                    iconData: notification.type.iconData,
                    iconSize: SdSpacingV5.s20,
                    color: tint,
                  ),
                ),
              ),
              SdHorizontalSpacingV5(value: SdSpacingV5.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: SdTextStyleV5.body14().wSemiBold().wColor(
                              colors.textDefault,
                            ),
                          ),
                        ),
                        SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                        Text(
                          _age(context, notification.timestamp),
                          style: SdTextStyleV5.body12().wColor(
                            colors.textSubTitle,
                          ),
                        ),
                      ],
                    ),
                    SdVerticalSpacingV5(value: SdSpacingV5.s4),
                    Text(
                      notification.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                    ),
                  ],
                ),
              ),
              if (isUnread) ...[
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                Padding(
                  padding: EdgeInsets.only(top: SdSpacingV5.s4),
                  child: Container(
                    width: SdSpacingV5.s8,
                    height: SdSpacingV5.s8,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Color _tint(BuildContext context, NotificationType type) {
    final colors = context.colorTheme;
    return switch (type) {
      NotificationType.orderUpdate => colors.primary,
      NotificationType.promotion => colors.sale,
      NotificationType.newProduct => colors.warning,
      NotificationType.account || NotificationType.general => colors.success,
    };
  }

  static String _age(BuildContext context, DateTime time) {
    final diff = DateTime.now().difference(time);
    final loc = context.loc;
    if (diff.inHours < 1) return loc.notifications_minutes_ago(diff.inMinutes);
    if (diff.inDays < 1) return loc.notifications_hours_ago(diff.inHours);
    return loc.notifications_days_ago(diff.inDays);
  }
}

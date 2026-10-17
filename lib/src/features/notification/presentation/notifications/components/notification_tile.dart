import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';

/// A notification: picture or glyph, title, body, how long ago, and a dot
/// while unread. Unread rows sit on a card; read ones fade back to the page.
class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.notification, required this.onTap, super.key});

  final NotificationEntity notification;
  final VoidCallback onTap;

  String _ago(BuildContext context) {
    final Duration d = DateTime.now().difference(notification.createdAt);

    if (d.inMinutes < 60) return context.loc.time_minutes_ago(d.inMinutes.clamp(1, 59));
    if (d.inHours < 24) return context.loc.time_hours_ago(d.inHours);
    return context.loc.time_days_ago(d.inDays);
  }

  @override
  Widget build(BuildContext context) {
    final NotificationEntity n = notification;
    final (IconData icon, Color tint) = switch (n.type) {
      NotificationType.order => (Symbols.local_shipping_rounded, context.sdTheme5.info),
      NotificationType.promotion => (Symbols.sell_rounded, context.sdTheme5.accent),
      NotificationType.newArrival => (Symbols.new_releases_rounded, context.sdTheme5.success),
      NotificationType.account => (Symbols.stars_rounded, context.sdTheme5.rating),
    };

    return SdPressableV5(
      onTap: onTap,
      pressedScale: 0.98,
      child: AnimatedContainer(
        duration: SdMotionV5.of(context, SdMotionV5.normal),
        padding: EdgeInsets.all(SdSpacingConstant.w12),
        decoration: BoxDecoration(
          color: n.isRead ? Colors.transparent : context.sdTheme5.surface,
          borderRadius: SdRadiusV5.cardAll,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox.square(
              dimension: SdSpacingConstant.r48,
              child: n.image == null
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: tint.withValues(alpha: 0.12),
                        borderRadius: SdRadiusV5.thumbnailAll,
                      ),
                      child: Center(child: SdIconV5(icon, color: tint, fill: 1)),
                    )
                  : AppImage(n.image!, borderRadius: SdRadiusV5.thumbnailAll),
            ),
            SizedBox(width: SdSpacingConstant.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          n.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme5.titleSmall,
                        ),
                      ),
                      Text(_ago(context), style: context.textTheme5.labelSmall!.faint5(context)),
                    ],
                  ),
                  SizedBox(height: SdSpacingConstant.h4),
                  Text(
                    n.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme5.bodySmall!.muted5(context),
                  ),
                ],
              ),
            ),
            SizedBox(width: SdSpacingConstant.w8),
            AnimatedScale(
              scale: n.isRead ? 0 : 1,
              duration: SdMotionV5.of(context, SdMotionV5.normal),
              child: Container(
                margin: EdgeInsets.only(top: SdSpacingConstant.h6),
                width: SdSpacingConstant.r8,
                height: SdSpacingConstant.r8,
                decoration: BoxDecoration(color: context.sdTheme5.accent, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

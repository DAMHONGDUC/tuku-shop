import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/session_controller.dart';
import 'package:tuku_shop/src/app/state/unread_notifications_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

/// "Good morning, Alex" with the avatar and the notification bell.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _greeting(BuildContext context) {
    final int hour = DateTime.now().hour;

    if (hour < 12) return context.loc.home_greeting_morning;
    if (hour < 18) return context.loc.home_greeting_afternoon;
    return context.loc.home_greeting_evening;
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = context.select<SessionController, UserEntity?>(
      (SessionController c) => c.state.user,
    );
    final int unread = context.watch<UnreadNotificationsController>().state;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        SdContentPaddingV5.horizontal,
        SdContentPaddingV5.statusBarInset(context) + SdSpacingConstant.h12,
        SdSpacingConstant.w12,
        0,
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => context.go(AppRoutes.profile.path),
            child: SdAvatarV5(
              initials: user?.initials ?? '',
              image: user?.avatar == null
                  ? null
                  : AppImage.provider(user!.avatar!),
              size: SdSpacingConstant.r44,
            ),
          ),
          SizedBox(width: SdSpacingConstant.w12),
          Expanded(
            child: SdFadeInV5(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _greeting(context),
                    style: context.textTheme5.bodySmall!.muted5(context),
                  ),
                  Text(
                    user?.firstName ?? context.loc.home_guest,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme5.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
          SdIconButtonV5(
            icon: Symbols.notifications_rounded,
            tooltip: context.loc.notifications_title,
            variant: SdIconButtonVariantV5.tonal,
            badgeCount: unread,
            onPressed: () => context.push(AppRoutes.notifications.path),
          ),
        ],
      ),
    );
  }
}

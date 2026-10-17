import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/session_controller.dart';
import 'package:tuku_shop/src/app/state/wishlist_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

import 'components/points_card.dart';
import 'components/profile_header.dart';
import 'components/profile_stats.dart';
import 'profile_controller.dart';

/// The Profile tab.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ProfileController>(
    create: (BuildContext _) => getIt<ProfileController>()..load(),
    child: const _ProfileView(),
  );
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  /// Opens a full-screen route, then refreshes the counts it may have changed.
  Future<void> _open(BuildContext context, String path) async {
    final ProfileController controller = context.read<ProfileController>();
    await context.push(path);
    await controller.load();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final SessionController session = context.read<SessionController>();

    final bool? confirmed = await showSdDialogV5<bool>(
      context,
      SdDialogV5(
        icon: Symbols.logout_rounded,
        title: context.loc.profile_logout_title,
        message: context.loc.profile_logout_message,
        actions: <SdDialogActionV5>[
          SdDialogActionV5(
            label: context.loc.action_cancel,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          SdDialogActionV5(
            label: context.loc.profile_logout,
            variant: SdButtonVariantV5.primary,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await session.logout();
    if (context.mounted) context.go(AppRoutes.login.path);
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = context.select<SessionController, UserEntity?>(
      (SessionController c) => c.state.user,
    );
    final int savedCount = context.select<WishlistController, int>(
      (WishlistController c) => c.state.length,
    );
    final int orderCount = context.select<ProfileController, int>(
      (ProfileController c) => c.state.orderCount,
    );

    final List<Widget> children = <Widget>[
      Text(context.loc.profile_title, style: context.textTheme5.displaySmall),
      SizedBox(height: SdSpacingConstant.h16),
      if (user != null) ...<Widget>[
        ProfileHeader(
          user: user,
          onEdit: () => _open(context, AppRoutes.editProfile.path),
        ),
        SizedBox(height: SdSpacingConstant.h16),
        PointsCard(points: user.points),
        SizedBox(height: SdSpacingConstant.h12),
      ],
      ProfileStats(
        orderCount: orderCount,
        savedCount: savedCount,
        onOrders: () => _open(context, AppRoutes.orders.path),
        onSaved: () => context.go(AppRoutes.wishlist.path),
      ),
      SizedBox(height: SdContentPaddingV5.sectionGap),
      SdSectionHeaderV5(title: context.loc.profile_section_shopping),
      SdListTileV5(
        icon: Symbols.receipt_long_rounded,
        title: context.loc.orders_title,
        onTap: () => _open(context, AppRoutes.orders.path),
      ),
      SdListTileV5(
        icon: Symbols.location_on_rounded,
        title: context.loc.addresses_title,
        onTap: () => _open(context, AppRoutes.addresses.path),
      ),
      SdListTileV5(
        icon: Symbols.credit_card_rounded,
        title: context.loc.payment_title,
        onTap: () => _open(context, AppRoutes.paymentMethods.path),
      ),
      SizedBox(height: SdContentPaddingV5.sectionGap),
      SdSectionHeaderV5(title: context.loc.profile_section_account),
      SdListTileV5(
        icon: Symbols.notifications_rounded,
        title: context.loc.notifications_title,
        onTap: () => _open(context, AppRoutes.notifications.path),
      ),
      SdListTileV5(
        icon: Symbols.settings_rounded,
        title: context.loc.settings_title,
        onTap: () => _open(context, AppRoutes.settings.path),
      ),
      SdListTileV5(
        icon: Symbols.help_rounded,
        title: context.loc.help_title,
        onTap: () => _open(context, AppRoutes.helpCenter.path),
      ),
      SizedBox(height: SdSpacingConstant.h8),
      SdListTileV5(
        icon: Symbols.logout_rounded,
        title: context.loc.profile_logout,
        destructive: true,
        onTap: () => _confirmLogout(context),
      ),
    ];

    return SdScaffoldV5(
      body: ListView(
        padding: SdContentPaddingV5.gutter.copyWith(
          top:
              SdContentPaddingV5.statusBarInset(context) +
              SdSpacingConstant.h16,
          bottom:
              SdContentPaddingV5.aboveNavBar(context) + SdSpacingConstant.h16,
        ),
        children: <Widget>[
          for (final (int i, Widget child) in children.indexed)
            SdFadeInV5(index: i, child: child),
        ],
      ),
    );
  }
}

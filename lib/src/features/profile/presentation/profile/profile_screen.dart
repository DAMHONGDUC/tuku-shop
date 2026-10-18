import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/settings/presentation/locale_controller.dart';

import 'profile_controller.dart';

/// The Profile tab: who you are, your orders at a glance, and settings.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileController>()..load(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  Future<void> _confirmReset(BuildContext context) async {
    final controller = context.read<ProfileController>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.loc.profile_reset_title),
        content: Text(context.loc.profile_reset_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.loc.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.loc.profile_reset_confirm),
          ),
        ],
      ),
    );
    if (ok == true) controller.resetDemoData();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final controller = context.read<ProfileController>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.loc.profile_logout_title),
        content: Text(context.loc.profile_logout_message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.loc.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(context.loc.profile_logout),
          ),
        ],
      ),
    );
    if (ok == true) controller.logout();
  }

  Future<void> _pickTheme(BuildContext context) async {
    final theme = AdaptiveTheme.of(context);
    final mode = await _pick<AdaptiveThemeMode>(
      context,
      title: context.loc.profile_theme,
      current: theme.mode,
      options: {
        AdaptiveThemeMode.system: context.loc.profile_theme_system,
        AdaptiveThemeMode.light: context.loc.profile_theme_light,
        AdaptiveThemeMode.dark: context.loc.profile_theme_dark,
      },
    );
    if (mode != null) theme.setThemeMode(mode);
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final controller = context.read<LocaleController>();
    final code = await _pick<String>(
      context,
      title: context.loc.profile_language,
      current: controller.state?.languageCode ?? 'system',
      options: {
        'system': context.loc.profile_theme_system,
        'en': 'English',
        'vi': 'Tiếng Việt',
      },
    );
    if (code != null) controller.select(code == 'system' ? null : code);
  }

  /// A bottom sheet of radio options; returns the picked value.
  Future<T?> _pick<T>(
    BuildContext context, {
    required String title,
    required T current,
    required Map<T, String> options,
  }) {
    final colors = context.colorTheme;
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      backgroundColor: colors.cardDefault,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(UIConstants.sheetRadius),
        ),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s24,
                  0,
                  SdSpacingV5.s24,
                  SdSpacingV5.s8,
                ),
                child: Text(
                  title,
                  style: SdTextStyleV5.heading16().wColor(colors.textDefault),
                ),
              ),
              for (final entry in options.entries)
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: SdSpacingV5.s24,
                  ),
                  title: Text(
                    entry.value,
                    style: SdTextStyleV5.body14().wColor(colors.textDefault),
                  ),
                  trailing: entry.key == current
                      ? Icon(Icons.check_rounded, color: colors.primary)
                      : null,
                  onTap: () => Navigator.pop(sheetContext, entry.key),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    return BlocConsumer<ProfileController, ProfileState>(
      listenWhen: (a, b) =>
          a.resets != b.resets ||
          a.loggedOut != b.loggedOut ||
          a.logoutFailed != b.logoutFailed,
      listener: (context, state) {
        if (state.loggedOut) {
          // Splash finds no session and routes to login.
          context.go(SplashRoutes.splash.fullPath);
        } else if (state.logoutFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(loc.logout_failed)));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(loc.profile_reset_done)));
        }
      },
      builder: (context, state) {
        final themeMode = AdaptiveTheme.of(context).mode;
        final locale = context.watch<LocaleController>().state;
        final controller = context.read<ProfileController>();

        return ColoredBox(
          color: colors.pageDefault,
          child: SafeArea(
            bottom: false,
            child: RefreshWrapper(
              onRefresh: controller.load,
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  FloatingBottomNav.contentInset(context),
                ),
                children: [
                  _Header(state: state),
                  SdVerticalSpacingV5(value: SdSpacingV5.s24),
                  _OrdersCard(state: state),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  _Group(
                    children: [
                      _Item(
                        icon: Icons.location_on_outlined,
                        label: loc.address_book_title,
                        onTap: () =>
                            context.push(AddressRoutes.addresses.fullPath),
                      ),
                      _Item(
                        icon: Icons.favorite_border,
                        label: loc.wishlist_title,
                        onTap: () =>
                            context.go(WishlistRoutes.wishlist.fullPath),
                      ),
                      _Item(
                        icon: Icons.notifications_none_rounded,
                        label: loc.notifications_title,
                        onTap: () => context.push(
                          NotificationsRoutes.notifications.fullPath,
                        ),
                      ),
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  _Group(
                    children: [
                      _Item(
                        icon: Icons.dark_mode_outlined,
                        label: loc.profile_theme,
                        value: switch (themeMode) {
                          AdaptiveThemeMode.light => loc.profile_theme_light,
                          AdaptiveThemeMode.dark => loc.profile_theme_dark,
                          _ => loc.profile_theme_system,
                        },
                        onTap: () => _pickTheme(context),
                      ),
                      _Item(
                        icon: Icons.translate_rounded,
                        label: loc.profile_language,
                        value: switch (locale?.languageCode) {
                          'en' => 'English',
                          'vi' => 'Tiếng Việt',
                          _ => loc.profile_theme_system,
                        },
                        onTap: () => _pickLanguage(context),
                      ),
                      _Item(
                        icon: Icons.restart_alt_rounded,
                        label: loc.profile_reset,
                        trailing: state.isResetting
                            ? SizedBox.square(
                                dimension: SdSpacingV5.s16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: colors.primary,
                                ),
                              )
                            : null,
                        onTap: () => _confirmReset(context),
                      ),
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  _Group(
                    children: [
                      _Item(
                        icon: Icons.logout_rounded,
                        label: loc.profile_logout,
                        danger: true,
                        onTap: () => _confirmLogout(context),
                      ),
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s16),
                  Center(
                    child: Text(
                      '${AppConstants.appName} · ${loc.profile_demo_note}',
                      style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final ProfileState state;

  static String initials(String name) => name
      .split(' ')
      .where((p) => p.isNotEmpty)
      .take(2)
      .map((p) => p[0].toUpperCase())
      .join();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final user = state.user;

    if (state.userStatus == ProfileSectionStatus.loading && user == null) {
      return Row(
        children: [
          const SkeletonBox(width: 64, height: 64, radius: 32),
          SdHorizontalSpacingV5(value: SdSpacingV5.s16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: 140, height: SdSpacingV5.s18),
                SizedBox(height: SdSpacingV5.s8),
                SkeletonBox(width: 180),
              ],
            ),
          ),
        ],
      );
    }
    if (user == null) {
      return SectionError(onRetry: context.read<ProfileController>().loadUser);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      onTap: () async {
        final updated = await context.push<UserEntity>(
          ProfileRoutes.editProfile.fullPath,
          extra: user,
        );
        if (updated != null && context.mounted) {
          context.read<ProfileController>().showUser(updated);
        }
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colors.primary,
            child: Text(
              initials(user.fullName),
              style: SdTextStyleV5.heading20().wColor(SdColorsV5.white),
            ),
          ),
          SdHorizontalSpacingV5(value: SdSpacingV5.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: SdTextStyleV5.heading20().wColor(colors.textDefault),
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s2),
                Text(
                  user.email,
                  style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                ),
              ],
            ),
          ),
          Icon(Icons.edit_outlined, color: colors.iconSecondary),
        ],
      ),
    );
  }
}

class _OrdersCard extends StatelessWidget {
  const _OrdersCard({required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;
    final shortcuts = [
      (
        OrderStatus.waitingForConfirmation,
        Icons.pending_actions_outlined,
        loc.order_status_to_confirm,
      ),
      (
        OrderStatus.waitingForPickup,
        Icons.inventory_2_outlined,
        loc.order_status_to_ship,
      ),
      (
        OrderStatus.waitingForDelivery,
        Icons.local_shipping_outlined,
        loc.order_status_on_the_way,
      ),
      (
        OrderStatus.delivered,
        Icons.check_circle_outline,
        loc.order_status_delivered,
      ),
    ];

    return Container(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      decoration: BoxDecoration(
        color: colors.cardDefault,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      ),
      child: Column(
        children: [
          SectionHeader(
            title: loc.orders_title,
            actionText: loc.common_see_all,
            onActionTap: () => context.push(MyOrderRoutes.myOrder.fullPath),
          ),
          if (state.countsStatus == ProfileSectionStatus.error)
            SectionError(onRetry: context.read<ProfileController>().loadCounts)
          else
            Row(
              children: [
                for (final (status, icon, label) in shortcuts)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                      onTap: () => context.push(
                        Uri(
                          path: MyOrderRoutes.myOrder.fullPath,
                          queryParameters: {
                            'status': '${OrderStatusExt.tabs.indexOf(status)}',
                          },
                        ).toString(),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: SdSpacingV5.s8),
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(icon, color: colors.primary),
                                if ((state.counts[status] ?? 0) > 0)
                                  Positioned(
                                    right: -SdSpacingV5.s10,
                                    top: -SdSpacingV5.s6,
                                    child: SdBadgeV5(
                                      count: state.counts[status]!,
                                      size: SdSpacingV5.s16,
                                      badgeColor: colors.sale,
                                    ),
                                  ),
                              ],
                            ),
                            SdVerticalSpacingV5(value: SdSpacingV5.s8),
                            Text(
                              label,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: SdTextStyleV5.body12().wColor(
                                colors.textSubTitle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.cardDefault,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(height: 1, indent: 56, color: colors.borderDefault),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.trailing,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final Widget? trailing;
  final bool danger;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final color = danger ? colors.sale : colors.textDefault;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SdSpacingV5.s16,
          vertical: SdSpacingV5.s14,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: SdSpacingV5.s22,
              color: danger ? colors.sale : colors.iconSecondary,
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s16),
            Expanded(
              child: Text(label, style: SdTextStyleV5.body14().wColor(color)),
            ),
            if (value != null)
              Text(
                value!,
                style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
              ),
            if (trailing != null) trailing!,
            if (!danger) ...[
              SdHorizontalSpacingV5(value: SdSpacingV5.s4),
              Icon(Icons.chevron_right_rounded, color: colors.iconSecondary),
            ],
          ],
        ),
      ),
    );
  }
}

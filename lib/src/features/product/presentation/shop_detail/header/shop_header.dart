import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

import 'shop_header_controller.dart';

/// The shop page cover: the shop's color as a gradient, its avatar, name,
/// Official badge and city, Follow and Chat, and four stats.
class ShopHeader extends StatelessWidget {
  const ShopHeader({super.key, required this.sellerId});

  final String sellerId;

  /// Cover height under the status bar, toolbar included.
  static const double coverHeight = kToolbarHeight + 156;

  static Color _parse(String hex) => Color(
    int.tryParse('FF${hex.replaceFirst('#', '')}', radix: 16) ?? 0xFF504EB7,
  );

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top + kToolbarHeight;

    return BlocBuilder<ShopHeaderController, ShopHeaderState>(
      builder: (context, state) {
        final seller = state.seller;
        final base = seller == null ? AppColors.brand : _parse(seller.colorHex);

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base, Color.lerp(base, AppColors.ink, 0.45)!],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              SdSpacingV5.s16,
              top,
              SdSpacingV5.s16,
              SdSpacingV5.s16,
            ),
            child: switch (state.status) {
              ShopHeaderStatus.loading => const _Skeleton(),
              ShopHeaderStatus.error => Center(
                child: TextButton.icon(
                  onPressed: () =>
                      context.read<ShopHeaderController>().load(sellerId),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(context.loc.common_retry),
                  style: TextButton.styleFrom(
                    foregroundColor: SdColorsV5.white,
                  ),
                ),
              ),
              ShopHeaderStatus.loaded => _Content(
                seller: seller!,
                productCount: state.productCount,
                isTogglingFollow: state.isTogglingFollow,
              ),
            },
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.seller,
    required this.productCount,
    required this.isTogglingFollow,
  });

  final Seller seller;
  final int? productCount;
  final bool isTogglingFollow;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    const white = SdColorsV5.white;
    final dim = white.withValues(alpha: 0.75);

    Widget stat(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: SdTextStyleV5.body14().wSemiBold().copyWith(
              color: white,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: SdTextStyleV5.body10().wColor(dim),
          ),
        ],
      ),
    );

    Widget divider() => Container(
      width: 1,
      height: SdSpacingV5.s24,
      color: white.withValues(alpha: 0.2),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(SdSpacingV5.s2),
              decoration: const BoxDecoration(
                color: white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: ShopHeader._parse(seller.colorHex),
                child: Text(
                  seller.initials,
                  style: SdTextStyleV5.heading18().wColor(white),
                ),
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    seller.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SdTextStyleV5.heading18().wColor(white).wDisplay(),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s4),
                  Row(
                    children: [
                      if (seller.isOfficial) ...[
                        TagChip(label: loc.chat_official, color: white),
                        SdHorizontalSpacingV5(value: SdSpacingV5.s6),
                      ],
                      SdIconV5(
                        iconData: Icons.location_on_outlined,
                        iconSize: SdSpacingV5.s14,
                        color: dim,
                      ),
                      SdHorizontalSpacingV5(value: SdSpacingV5.s2),
                      Flexible(
                        child: Text(
                          seller.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: SdTextStyleV5.body12().wColor(dim),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s8),
            Column(
              children: [
                _HeaderButton(
                  label: seller.isFollowed
                      ? loc.shop_following
                      : loc.shop_follow,
                  icon: seller.isFollowed
                      ? Icons.check_rounded
                      : Icons.add_rounded,
                  filled: !seller.isFollowed,
                  isLoading: isTogglingFollow,
                  onTap: context.read<ShopHeaderController>().toggleFollow,
                ),
                SdVerticalSpacingV5(value: SdSpacingV5.s8),
                _HeaderButton(
                  label: loc.pdp_chat,
                  icon: Icons.chat_bubble_outline_rounded,
                  onTap: () =>
                      context.push(ChatRoutes.threadLocation(seller.id)),
                ),
              ],
            ),
          ],
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s16),
        Row(
          children: [
            stat('★ ${seller.rating.toStringAsFixed(1)}', loc.filter_rating),
            divider(),
            stat(productCount?.toString() ?? '–', loc.shop_stat_products),
            divider(),
            stat(
              AppFormat.compactCount(seller.followerCount),
              loc.pdp_followers,
            ),
            divider(),
            stat('${seller.responseRate}%', loc.pdp_response_rate),
          ],
        ),
      ],
    );
  }
}

/// A compact pill on the cover: white fill (Follow) or white outline.
class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
    this.isLoading = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    const white = SdColorsV5.white;
    final fg = filled ? AppColors.ink : white;

    return SizedBox(
      width: 112,
      height: SdSpacingV5.s32,
      child: Material(
        color: filled ? white : SdColorsV5.transparent,
        shape: StadiumBorder(
          side: BorderSide(color: white.withValues(alpha: filled ? 1 : 0.7)),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: isLoading ? null : onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox.square(
                  dimension: SdSpacingV5.s14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                )
              else
                SdIconV5(iconData: icon, iconSize: SdSpacingV5.s16, color: fg),
              SdHorizontalSpacingV5(value: SdSpacingV5.s4),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: SdTextStyleV5.body12().wSemiBold().wColor(fg),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    final shade = SdColorsV5.white.withValues(alpha: 0.2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            SkeletonBox(width: 60, height: 60, radius: 30, color: shade),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(
                    width: 160,
                    height: SdSpacingV5.s18,
                    color: shade,
                  ),
                  const SizedBox(height: SdSpacingV5.s8),
                  SkeletonBox(width: 100, color: shade),
                ],
              ),
            ),
          ],
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s16),
        SkeletonBox(height: SdSpacingV5.s32, color: shade),
      ],
    );
  }
}

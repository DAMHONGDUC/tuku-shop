import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

import 'product_seller_controller.dart';

/// "Sold by": the shop's avatar, name, Official badge and stats, with Chat
/// and View shop.
class ShopSection extends StatelessWidget {
  const ShopSection({super.key, required this.sellerId});

  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductSellerController>()..load(sellerId),
      child: BlocBuilder<ProductSellerController, ProductSellerState>(
        builder: (context, state) => switch (state.status) {
          ProductSellerStatus.loading => const _Skeleton(),
          ProductSellerStatus.error => SectionError(
            onRetry: () =>
                context.read<ProductSellerController>().load(sellerId),
          ),
          ProductSellerStatus.loaded => _ShopCard(seller: state.seller!),
        },
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.seller});

  final Seller seller;

  static Color _parse(String hex) => Color(
    int.tryParse('FF${hex.replaceFirst('#', '')}', radix: 16) ?? 0xFF504EB7,
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;

    Widget stat(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: SdTextStyleV5.body14().wSemiBold().copyWith(
              color: colors.textDefault,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: SdTextStyleV5.body10().wColor(colors.textSubTitle),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          loc.pdp_sold_by,
          style: SdTextStyleV5.heading16().wColor(colors.textDefault),
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Row(
          children: [
            Container(
              width: SdSpacingV5.s48,
              height: SdSpacingV5.s48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _parse(seller.colorHex),
                shape: BoxShape.circle,
              ),
              child: Text(
                seller.initials,
                style: SdTextStyleV5.heading16().wColor(SdColorsV5.white),
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          seller.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: SdTextStyleV5.body14().wSemiBold().wColor(
                            colors.textDefault,
                          ),
                        ),
                      ),
                      if (seller.isOfficial) ...[
                        SdHorizontalSpacingV5(value: SdSpacingV5.s6),
                        TagChip(
                          label: loc.chat_official,
                          color: colors.primary,
                        ),
                      ],
                    ],
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s2),
                  Row(
                    children: [
                      SdIconV5(
                        iconData: Icons.location_on_outlined,
                        iconSize: SdSpacingV5.s14,
                        color: colors.iconSecondary,
                      ),
                      SdHorizontalSpacingV5(value: SdSpacingV5.s2),
                      Text(
                        seller.location,
                        style: SdTextStyleV5.body12().wColor(
                          colors.textSubTitle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Row(
          children: [
            stat('★ ${seller.rating.toStringAsFixed(1)}', loc.filter_rating),
            stat('${seller.responseRate}%', loc.pdp_response_rate),
            stat(
              AppFormat.compactCount(seller.followerCount),
              loc.pdp_followers,
            ),
          ],
        ),
        SdVerticalSpacingV5(value: SdSpacingV5.s12),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: loc.pdp_chat,
                leadingIcon: Icons.chat_bubble_outline_rounded,
                style: AppButtonStyle.soft,
                onTap: () => context.push(ChatRoutes.threadLocation(seller.id)),
              ),
            ),
            SdHorizontalSpacingV5(value: SdSpacingV5.s12),
            Expanded(
              child: AppButton(
                label: loc.pdp_view_shop,
                leadingIcon: Icons.storefront_outlined,
                style: AppButtonStyle.soft,
                onTap: () => context.push(
                  ProductRoutes.productListLocation(
                    title: seller.name,
                    sellerId: seller.id,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SkeletonBox(width: 48, height: 48, radius: 24),
        SdHorizontalSpacingV5(value: SdSpacingV5.s12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(width: 160),
              SizedBox(height: SdSpacingV5.s8),
              SkeletonBox(width: 100),
            ],
          ),
        ),
      ],
    );
  }
}

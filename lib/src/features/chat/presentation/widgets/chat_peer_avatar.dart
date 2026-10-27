import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

/// A shop's initials on its color, or the support desk's headset.
class ChatPeerAvatar extends StatelessWidget {
  const ChatPeerAvatar({super.key, this.seller, this.size = SdSpacingV5.s48});

  /// Null for the support desk.
  final Seller? seller;
  final double size;

  static Color _parse(String hex) => Color(
    int.tryParse('FF${hex.replaceFirst('#', '')}', radix: 16) ?? 0xFF504EB7,
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final shop = seller;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: shop == null ? colors.primarySoft : _parse(shop.colorHex),
        shape: BoxShape.circle,
      ),
      child: shop == null
          ? SdIconV5(
              iconData: Icons.support_agent_rounded,
              iconSize: size * 0.5,
              color: colors.primary,
            )
          : Text(
              shop.initials,
              style: SdTextStyleV5.body14()
                  .wSemiBold()
                  .wColor(SdColorsV5.white)
                  .copyWith(fontSize: size * 0.34),
            ),
    );
  }
}

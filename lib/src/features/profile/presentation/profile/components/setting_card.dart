import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.setting, this.onTap});

  final SettingItemEntity setting;
  final ValueChanged<SettingItemEntity>? onTap;

  @override
  Widget build(BuildContext context) {
    return SdInkWellV5(
      onTap: () => onTap?.call(setting),
      containerBg: context.colorTheme.cardDefault,
      borderRadius: SdSpacingV5.s12,
      contentPadding: EdgeInsets.all(SdSpacingV5.s12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SdIconV5(iconData: setting.iconData, color: setting.iconColor),
              SdHorizontalSpacingV5(),
              Text(
                setting.name,
                style: SdTextStyleV5.body14().wSemiBold().copyWith(
                  color: setting.nameColor,
                ),
              ),
            ],
          ),
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

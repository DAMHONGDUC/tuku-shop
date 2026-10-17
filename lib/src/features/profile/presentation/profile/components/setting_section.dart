import 'package:tuku_shop/src/features/profile/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/components/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({
    super.key,
    required this.settingSection,
    this.onItemTap,
  });
  final SettingSectionEntity settingSection;
  final ValueChanged<SettingItemEntity>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(settingSection.name, style: SdTextStyleV5.heading16()),
        SdVerticalSpacingV5(),
        SdListViewV5(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: settingSection.items,
          separatorBuilder: (_, index) {
            return SdVerticalSpacingV5();
          },
          itemBuilder: (_, index) {
            return SettingCard(
              setting: settingSection.items[index],
              onTap: onItemTap,
            );
          },
        ),
      ],
    );
  }
}

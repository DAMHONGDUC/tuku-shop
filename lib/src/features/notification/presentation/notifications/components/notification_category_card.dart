import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class NotificationCategoryCard extends StatelessWidget {
  final NotificationCategory category;
  final VoidCallback onTap;

  const NotificationCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SdInkWellV5(
      onTap: onTap,
      borderRadius: 0,
      containerBg: context.colorTheme.cardDefault,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(SdSpacingV5.s8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: context.colorTheme.borderDefault,
                    ),
                    borderRadius: BorderRadius.circular(SdSpacingV5.s100),
                  ),
                  child: SdIconV5(
                    iconData: category.icon,
                    color: category.type.iconColor,
                    iconSize: SdSpacingV5.s28,
                  ),
                ),
                SdHorizontalSpacingV5(),
                Row(
                  children: [
                    _InfoSectio(
                      name: category.name,
                      description: category.description,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SdHorizontalSpacingV5(xRatio: 0.5),
          Row(
            children: [
              SdBadgeV5(
                count: category.numOfNotifications,
                size: SdSpacingV5.s20,
              ),
              SdHorizontalSpacingV5(),
              SdIconV5(
                iconData: Icons.chevron_right,
                iconSize: SdSpacingV5.s20,
                color: context.colorTheme.iconSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoSectio extends StatelessWidget {
  const _InfoSectio({required this.name, required this.description});
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: SdTextStyleV5.heading14(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SdVerticalSpacingV5(xRatio: 0.25),
        Text(
          description,
          style: SdTextStyleV5.body12().wColor(context.colorTheme.textSubTitle),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

import 'package:tuku_shop/src/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final String? iconPath;
  final double iconSize;

  const EmptyView({
    super.key,
    this.message = 'No data available',
    this.iconPath = 'assets/icons/ic_empty_box.png',
    this.iconSize = SdSpacingV5.s100,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SdIconV5(iconPath: iconPath!, iconSize: iconSize),
          SdVerticalSpacingV5(),
          Text(
            message,
            style: SdTextStyleV5.body14().wColor(
              context.colorTheme.textSubTitle,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

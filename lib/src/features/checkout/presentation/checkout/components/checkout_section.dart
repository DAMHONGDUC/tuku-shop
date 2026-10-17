import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

/// A numbered checkout step with an optional action ("Change") on the right.
class CheckoutSection extends StatelessWidget {
  const CheckoutSection({
    required this.step,
    required this.title,
    required this.child,
    this.action,
    this.onAction,
    super.key,
  });

  final int step;
  final String title;
  final Widget child;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: SdContentPaddingV5.sectionGap * 0.8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: SdSpacingConstant.r24,
              height: SdSpacingConstant.r24,
              decoration: BoxDecoration(
                color: context.sdTheme5.textPrimary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$step',
                style: context.textTheme5.labelMedium!.bold5.copyWith(
                  color: context.sdTheme5.background,
                ),
              ),
            ),
            SizedBox(width: SdSpacingConstant.w12),
            Expanded(child: Text(title, style: context.textTheme5.titleMedium)),
            if (action != null)
              SdButtonV5(
                variant: SdButtonVariantV5.text,
                size: SdButtonSizeV5.small,
                label: action!,
                onPressed: onAction,
              ),
          ],
        ),
        SizedBox(height: SdSpacingConstant.h12),
        child,
      ],
    ),
  );
}

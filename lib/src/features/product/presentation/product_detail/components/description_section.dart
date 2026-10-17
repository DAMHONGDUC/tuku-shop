import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// The copy, folded to a few lines until "Read more", then the highlights
/// and the fabric.
class DescriptionSection extends StatefulWidget {
  const DescriptionSection({required this.product, super.key});

  final ProductEntity product;

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final ProductEntity product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SdSectionHeaderV5(title: context.loc.detail_description),
        SizedBox(height: SdSpacingConstant.h10),
        AnimatedSize(
          duration: SdMotionV5.of(context, SdMotionV5.normal),
          curve: SdMotionV5.standard,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.description,
                maxLines: _open ? null : 3,
                overflow: _open ? null : TextOverflow.ellipsis,
                style: context.textTheme5.bodyMedium!.muted5(context),
              ),
              if (_open) ...<Widget>[
                SizedBox(height: SdSpacingConstant.h12),
                for (final String h in product.highlights)
                  Padding(
                    padding: EdgeInsets.only(bottom: SdSpacingConstant.h6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SdIconV5(
                          Symbols.check_rounded,
                          size: SdIconV5.smallSize,
                          color: context.sdTheme5.success,
                        ),
                        SizedBox(width: SdSpacingConstant.w8),
                        Expanded(
                          child: Text(h, style: context.textTheme5.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                if (product.material.isNotEmpty) ...<Widget>[
                  SizedBox(height: SdSpacingConstant.h6),
                  Text.rich(
                    TextSpan(
                      text: '${context.loc.detail_material}: ',
                      style: context.textTheme5.bodyMedium!.semiBold5,
                      children: <InlineSpan>[
                        TextSpan(
                          text: product.material,
                          style: context.textTheme5.bodyMedium!.muted5(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
        SdButtonV5(
          variant: SdButtonVariantV5.text,
          size: SdButtonSizeV5.small,
          label: _open
              ? context.loc.detail_read_less
              : context.loc.detail_read_more,
          trailingIcon: _open
              ? Symbols.expand_less_rounded
              : Symbols.expand_more_rounded,
          onPressed: () => setState(() => _open = !_open),
        ),
      ],
    );
  }
}

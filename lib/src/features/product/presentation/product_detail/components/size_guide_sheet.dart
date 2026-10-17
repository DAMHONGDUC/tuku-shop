import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

Future<void> showSizeGuide(BuildContext context, ProductEntity product) =>
    showSdBottomSheetV5<void>(
      context: context,
      builder: (BuildContext _) => _SizeGuideSheet(product: product),
    );

/// Body measurements per size: letter sizes for tops, waist for bottoms.
class _SizeGuideSheet extends StatelessWidget {
  const _SizeGuideSheet({required this.product});

  final ProductEntity product;

  static const Map<String, (String, String, String)> _tops =
      <String, (String, String, String)>{
        'XS': ('32–34', '26–28', '34–36'),
        'S': ('35–37', '29–31', '37–39'),
        'M': ('38–40', '32–34', '40–42'),
        'L': ('41–43', '35–37', '43–45'),
        'XL': ('44–46', '38–40', '46–48'),
      };

  @override
  Widget build(BuildContext context) {
    final bool letters = product.sizes.any(_tops.containsKey);
    final TextStyle head = context.textTheme5.labelMedium!.faint5(context);
    final TextStyle cell = context.textTheme5.bodyMedium!.tabular5;

    return SdBottomSheetV5(
      title: context.loc.detail_size_guide,
      closeTooltip: context.loc.action_close,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            letters
                ? context.loc.size_guide_tops
                : context.loc.size_guide_bottoms,
            style: context.textTheme5.bodyMedium!.muted5(context),
          ),
          SizedBox(height: SdSpacingConstant.h16),
          SdCardV5(
            layer: SdCardLayerV5.outlined,
            padding: EdgeInsets.zero,
            child: Table(
              children: <TableRow>[
                TableRow(
                  decoration: BoxDecoration(
                    color: context.sdTheme5.surfaceSunken,
                  ),
                  children: <Widget>[
                    for (final String h
                        in letters
                            ? <String>[
                                context.loc.detail_size,
                                context.loc.size_chest,
                                context.loc.size_waist,
                                context.loc.size_hips,
                              ]
                            : <String>[
                                context.loc.detail_size,
                                context.loc.size_waist,
                              ])
                      _Cell(text: h, style: head),
                  ],
                ),
                for (final String size in product.sizes)
                  TableRow(
                    children: <Widget>[
                      _Cell(text: size, style: cell.semiBold5),
                      if (letters) ...<Widget>[
                        _Cell(text: _tops[size]?.$1 ?? '—', style: cell),
                        _Cell(text: _tops[size]?.$2 ?? '—', style: cell),
                        _Cell(text: _tops[size]?.$3 ?? '—', style: cell),
                      ] else
                        _Cell(text: '$size″', style: cell),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(height: SdSpacingConstant.h12),
          Text(
            context.loc.size_guide_note,
            style: context.textTheme5.bodySmall!.faint5(context),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: SdSpacingConstant.w12,
      vertical: SdSpacingConstant.h12,
    ),
    child: Text(text, style: style),
  );
}

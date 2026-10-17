import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

Future<void> showFilterSheet(
  BuildContext context, {
  required ProductQuery query,
  required ValueChanged<ProductQuery> onApply,
}) => showSdBottomSheetV5<void>(
  context: context,
  builder: (BuildContext _) => FilterSheet(query: query, onApply: onApply),
);

/// Price, size, colour and the two toggles. Edits a draft and hands it back
/// only on "Show results", so dismissing the sheet changes nothing.
class FilterSheet extends StatefulWidget {
  const FilterSheet({required this.query, required this.onApply, super.key});

  final ProductQuery query;
  final ValueChanged<ProductQuery> onApply;

  static const double maxPrice = 100;

  static const List<String> sizes = <String>[
    'XS',
    'S',
    'M',
    'L',
    'XL',
    '28',
    '29',
    '30',
    '32',
    '34',
    '36',
  ];

  static const List<(String, String)> colors = <(String, String)>[
    ('Black', '#1F1F22'),
    ('White', '#F4F4F2'),
    ('Gray', '#9B9BA0'),
    ('Blue', '#3A6FD6'),
    ('Green', '#4E9E72'),
    ('Red', '#CF3F3B'),
    ('Orange', '#EE8B3A'),
    ('Yellow', '#F1C94B'),
    ('Purple', '#7E5BA8'),
  ];

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late ProductQuery _draft = widget.query;

  RangeValues get _range => RangeValues(
    _draft.minPrice ?? 0,
    _draft.maxPrice ?? FilterSheet.maxPrice,
  );

  void _toggle(
    Set<String> set,
    String value,
    ProductQuery Function(Set<String>) apply,
  ) {
    final Set<String> next = Set<String>.of(set);

    if (!next.remove(value)) next.add(value);
    setState(() => _draft = apply(next));
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle heading = context.textTheme5.titleSmall!;

    return SdBottomSheetV5(
      title: context.loc.filter_title,
      closeTooltip: context.loc.action_close,
      trailing: SdButtonV5(
        variant: SdButtonVariantV5.text,
        size: SdButtonSizeV5.small,
        label: context.loc.filter_reset,
        onPressed: () => setState(() => _draft = _draft.cleared()),
      ),
      footer: SdButtonV5(
        variant: SdButtonVariantV5.primary,
        label: context.loc.filter_apply,
        expand: true,
        onPressed: () {
          Navigator.of(context).pop();
          widget.onApply(_draft.copyWith(page: 1));
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(context.loc.filter_price, style: heading)),
              Text(
                '${Formatters.currency(_range.start)} – ${Formatters.currency(_range.end)}',
                style: context.textTheme5.labelLarge!.tabular5,
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: context.sdTheme5.textPrimary,
              inactiveTrackColor: context.sdTheme5.surfaceSunken,
              thumbColor: context.sdTheme5.textPrimary,
              overlayColor: context.sdTheme5.textPrimary.withValues(
                alpha: 0.08,
              ),
              trackHeight: SdSpacingConstant.h4,
            ),
            child: RangeSlider(
              values: _range,
              max: FilterSheet.maxPrice,
              divisions: 20,
              onChanged: (RangeValues v) => setState(
                () => _draft = _draft.copyWith(
                  minPrice: () => v.start <= 0 ? null : v.start,
                  maxPrice: () => v.end >= FilterSheet.maxPrice ? null : v.end,
                ),
              ),
            ),
          ),
          SizedBox(height: SdSpacingConstant.h12),
          Text(context.loc.filter_size, style: heading),
          SizedBox(height: SdSpacingConstant.h10),
          Wrap(
            spacing: SdSpacingConstant.w8,
            runSpacing: SdSpacingConstant.h8,
            children: <Widget>[
              for (final String size in FilterSheet.sizes)
                SdChipV5(
                  label: size,
                  minWidth: SdSpacingConstant.w56,
                  selected: _draft.sizes.contains(size),
                  onSelected: () => _toggle(
                    _draft.sizes,
                    size,
                    (Set<String> s) => _draft.copyWith(sizes: s),
                  ),
                ),
            ],
          ),
          SizedBox(height: SdSpacingConstant.h20),
          Text(context.loc.filter_color, style: heading),
          SizedBox(height: SdSpacingConstant.h10),
          Wrap(
            spacing: SdSpacingConstant.w8,
            runSpacing: SdSpacingConstant.h8,
            children: <Widget>[
              for (final (String name, String hex) in FilterSheet.colors)
                SdColorSwatchV5(
                  color: hexColor(hex),
                  semanticLabel: name,
                  selected: _draft.colors.contains(name),
                  onSelected: () => _toggle(
                    _draft.colors,
                    name,
                    (Set<String> c) => _draft.copyWith(colors: c),
                  ),
                ),
            ],
          ),
          SizedBox(height: SdSpacingConstant.h12),
          SdListTileV5(
            title: context.loc.filter_on_sale,
            trailing: SdSwitchV5(
              value: _draft.onSaleOnly,
              semanticLabel: context.loc.filter_on_sale,
              onChanged: (bool v) =>
                  setState(() => _draft = _draft.copyWith(onSaleOnly: v)),
            ),
          ),
          SdListTileV5(
            title: context.loc.filter_new_only,
            trailing: SdSwitchV5(
              value: _draft.newOnly,
              semanticLabel: context.loc.filter_new_only,
              onChanged: (bool v) =>
                  setState(() => _draft = _draft.copyWith(newOnly: v)),
            ),
          ),
        ],
      ),
    );
  }
}

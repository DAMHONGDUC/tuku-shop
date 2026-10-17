import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/cart_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

Future<void> showQuickAddSheet(BuildContext context, ProductEntity product) =>
    showSdBottomSheetV5<void>(
      context: context,
      builder: (BuildContext _) => QuickAddSheet(product: product),
    );

/// Colour and size without leaving the list, then straight into the bag.
class QuickAddSheet extends StatefulWidget {
  const QuickAddSheet({required this.product, super.key});

  final ProductEntity product;

  @override
  State<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends State<QuickAddSheet> {
  int _color = 0;
  late String? _size = widget.product.sizes.length == 1
      ? widget.product.sizes.first
      : null;
  bool _busy = false;
  int _nudge = 0;

  Future<void> _add() async {
    if (_size == null) {
      setState(() => _nudge++);
      return;
    }

    setState(() => _busy = true);

    final ProductEntity p = widget.product;
    final ProductColor color = p.colors[_color];
    final bool ok = await context.read<CartController>().add(
      AddToCartParams(
        productId: p.id,
        name: p.name,
        brand: p.brand,
        image: color.images.first,
        color: color.name,
        size: _size!,
        unitPrice: p.price,
        compareAtPrice: p.compareAtPrice,
      ),
    );

    if (!mounted) return;

    Navigator.of(context).pop();
    if (ok) SdSnackBarUtilsV5.success(context, context.loc.detail_added);
  }

  @override
  Widget build(BuildContext context) {
    final ProductEntity p = widget.product;
    final ProductColor color = p.colors[_color];

    return SdBottomSheetV5(
      title: context.loc.wishlist_move_to_bag,
      closeTooltip: context.loc.action_close,
      footer: SdButtonV5(
        variant: SdButtonVariantV5.primary,
        label: '${context.loc.detail_add_to_bag}  ·  ${Formatters.currency(p.price)}',
        expand: true,
        busy: _busy,
        onPressed: _add,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: SdSpacingConstant.w64 * 1.2,
                height: SdSpacingConstant.w64 * 1.5,
                child: AnimatedSwitcher(
                  duration: SdMotionV5.normal,
                  child: AppImage(
                    color.images.first,
                    key: ValueKey<String>(color.name),
                    borderRadius: SdRadiusV5.thumbnailAll,
                  ),
                ),
              ),
              SizedBox(width: SdSpacingConstant.w14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(p.name, style: context.textTheme5.titleMedium),
                    SizedBox(height: SdSpacingConstant.h6),
                    SdPriceV5(
                      price: Formatters.currency(p.price),
                      compareAt: p.isOnSale ? Formatters.currency(p.compareAtPrice!) : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SdSpacingConstant.h20),
          Text('${context.loc.detail_color}: ${color.name}', style: context.textTheme5.titleSmall),
          SizedBox(height: SdSpacingConstant.h10),
          Wrap(
            spacing: SdSpacingConstant.w8,
            children: <Widget>[
              for (final (int i, ProductColor c) in p.colors.indexed)
                SdColorSwatchV5(
                  color: hexColor(c.hex),
                  semanticLabel: c.name,
                  selected: i == _color,
                  onSelected: () => setState(() => _color = i),
                ),
            ],
          ),
          SizedBox(height: SdSpacingConstant.h20),
          Text(context.loc.detail_size, style: context.textTheme5.titleSmall),
          SizedBox(height: SdSpacingConstant.h10),
          Shake(
            trigger: _nudge,
            child: Wrap(
              spacing: SdSpacingConstant.w8,
              runSpacing: SdSpacingConstant.h8,
              children: <Widget>[
                for (final String s in p.sizes)
                  SdChipV5(
                    label: s,
                    minWidth: SdSpacingConstant.w56,
                    selected: s == _size,
                    onSelected: () => setState(() => _size = s),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

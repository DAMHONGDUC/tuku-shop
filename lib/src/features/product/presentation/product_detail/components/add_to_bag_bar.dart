import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../../widgets/product_card.dart';
import '../product_detail_controller.dart';

/// The pinned bar: the heart and "Add to bag". A successful add swaps the
/// label to a check for a moment, so the press is answered on the button the
/// thumb is still on.
class AddToBagBar extends StatefulWidget {
  const AddToBagBar({super.key});

  @override
  State<AddToBagBar> createState() => _AddToBagBarState();
}

class _AddToBagBarState extends State<AddToBagBar> {
  bool _justAdded = false;

  Future<void> _add() async {
    final ProductDetailController controller = context.read<ProductDetailController>();
    final bool added = await controller.addToBag();

    if (!mounted) return;

    if (!added) {
      if (controller.state.size == null) {
        HapticFeedback.mediumImpact();
        SdSnackBarUtilsV5.info(context, context.loc.detail_choose_size);
      }
      return;
    }

    HapticFeedback.lightImpact();
    setState(() => _justAdded = true);
    SdSnackBarUtilsV5.success(context, context.loc.detail_added);
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (mounted) setState(() => _justAdded = false);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailController, ProductDetailState>(
        builder: (BuildContext context, ProductDetailState state) => Container(
          padding: EdgeInsets.fromLTRB(
            SdContentPaddingV5.horizontal,
            SdSpacingConstant.h12,
            SdContentPaddingV5.horizontal,
            SdContentPaddingV5.detailBottom(context),
          ),
          decoration: BoxDecoration(
            color: context.sdTheme5.surface,
            border: Border(top: BorderSide(color: context.sdTheme5.divider)),
          ),
          child: Row(
            children: <Widget>[
              ProductLikeButton(
                productId: state.product!.id,
                size: SdSpacingConstant.r48,
              ),
              SizedBox(width: SdSpacingConstant.w12),
              Expanded(
                child: _justAdded
                    ? SdButtonV5(
                        key: const ValueKey<String>('added'),
                        variant: SdButtonVariantV5.secondary,
                        size: SdButtonSizeV5.large,
                        label: context.loc.detail_view_bag,
                        icon: Symbols.check_circle_rounded,
                        expand: true,
                        onPressed: () => context.go(AppRoutes.cart.path),
                      )
                    : SdButtonV5(
                        key: const ValueKey<String>('add'),
                        variant: SdButtonVariantV5.primary,
                        size: SdButtonSizeV5.large,
                        label:
                            '${context.loc.detail_add_to_bag}  ·  ${Formatters.currency(state.product!.price * state.quantity)}',
                        icon: Symbols.shopping_bag_rounded,
                        expand: true,
                        busy: state.adding,
                        onPressed: _add,
                      ),
              ),
            ],
          ),
        ),
      );
}

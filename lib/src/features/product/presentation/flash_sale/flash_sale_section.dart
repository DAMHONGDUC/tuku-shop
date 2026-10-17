import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import '../widgets/product_rail.dart';
import 'flash_sale_controller.dart';

/// "Flash sale" with a live countdown and the deepest markdowns.
class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<FlashSaleController>(
    create: (BuildContext _) => getIt<FlashSaleController>()..load(),
    child: BlocBuilder<FlashSaleController, FlashSaleState>(
      builder: (BuildContext context, FlashSaleState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: SdContentPaddingV5.gutter,
            child: SdSectionHeaderV5(
              title: context.loc.home_flash_sale,
              subtitle: context.loc.home_flash_sale_subtitle,
              trailing: state.sale == null
                  ? null
                  : _Countdown(endsAt: state.sale!.endsAt),
            ),
          ),
          SizedBox(height: SdSpacingConstant.h14),
          FadeSwitcher(
            child: state.status == LoadStatus.success
                ? ProductRail(
                    products: state.sale!.products,
                    heroPrefix: 'flash',
                  )
                : const ProductRailSkeleton(),
          ),
          SizedBox(height: SdSpacingConstant.h8),
          Padding(
            padding: SdContentPaddingV5.gutter,
            child: SdButtonV5(
              variant: SdButtonVariantV5.secondary,
              label: context.loc.home_flash_sale_all,
              trailingIcon: Symbols.arrow_forward_rounded,
              expand: true,
              size: SdButtonSizeV5.small,
              onPressed: () => context.push(
                AppRoutes.productListPath(
                  ProductListArgs(
                    title: context.loc.home_flash_sale,
                    onSaleOnly: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Ticks once a second. The clock is UI; the end time came from the data.
class _Countdown extends StatefulWidget {
  const _Countdown({required this.endsAt});

  final DateTime endsAt;

  @override
  State<_Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<_Countdown> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer _) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Duration left = widget.endsAt.difference(DateTime.now());

    return Padding(
      padding: EdgeInsets.only(left: SdSpacingConstant.w8),
      child: SdCountdownV5(
        remaining: left,
        semanticLabel: context.loc.home_flash_sale_ends(
          '${left.inHours}:${(left.inMinutes % 60).toString().padLeft(2, '0')}',
        ),
      ),
    );
  }
}

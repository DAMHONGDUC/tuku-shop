import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/order/presentation/widgets/title_content_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import 'my_order_detail_args.dart';
import 'my_order_detail_controller.dart';

const _kImgThumbnailSize = 80.0;

class MyOrderDetailScreen extends StatelessWidget {
  const MyOrderDetailScreen({super.key, required this.args});
  final MyOrderDetailArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<MyOrderDetailController>()
            ..getOrderDetail(orderId: args.orderId),
      child: const _MyOrderDetailView(),
    );
  }
}

class _MyOrderDetailView extends StatelessWidget {
  const _MyOrderDetailView();

  @override
  Widget build(BuildContext context) {
    return SdSafeAreaScaffoldV5(
      backgroundColor: context.colorTheme.pageDefault,
      contentBgColor: context.colorTheme.pageDefault,
      appBar: AppBar(
        title: const Text('Order Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      child: BlocBuilder<MyOrderDetailController, MyOrderDetailState>(
        builder: (context, state) {
          if (state is MyOrderDetailLoadingState ||
              state is MyOrderDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyOrderDetailErrorState) {
            return EmptyView(message: state.errorMsg);
          } else if (state is MyOrderDetailLoadedState) {
            return _OrderDetailContent(order: state.order);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _OrderDetailContent extends StatelessWidget {
  const _OrderDetailContent({required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(SdSpacingV5.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SdTagV5(
                label: order.status.label,
                color: order.status.color,
                borderRadiusValue: SdSpacingV5.s8,
              ),
            ],
          ),
          SdVerticalSpacingV5(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SdImageV5(
                borderRadiusValue: SdSpacingV5.s6,
                imagePath: order.productThumbnailUrl,
                width: _kImgThumbnailSize,
                height: _kImgThumbnailSize,
              ),
              SdHorizontalSpacingV5(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.productName, style: SdTextStyleV5.heading14()),
                    SdVerticalSpacingV5(xRatio: 0.5),
                    TitleContentRow(
                      title: 'Color',
                      content: order.productColor.colorName,
                    ),
                    SdVerticalSpacingV5(xRatio: 0.25),
                    TitleContentRow(
                      title: 'Size',
                      content: order.productSize.name,
                    ),
                    SdVerticalSpacingV5(xRatio: 0.25),
                    TitleContentRow(
                      title: 'Quantity',
                      content: order.quantity.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s24),
          const Divider(),
          SdVerticalSpacingV5(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: SdTextStyleV5.heading14()),
              Text(
                SdCurrencyFormatHelperV5.formatPrice(order.totalPrice),
                style: SdTextStyleV5.heading14().wBold(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

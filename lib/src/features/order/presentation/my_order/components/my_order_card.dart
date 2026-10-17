import 'package:tuku_shop/src/core/enums/order_status.dart';
import 'package:tuku_shop/src/core/resources/resources.dart';
import 'package:tuku_shop/src/features/order/presentation/widgets/title_content_row.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/order/presentation/my_order/config/my_order_routes.dart';
import 'package:tuku_shop/src/features/order/presentation/my_order/my_order_detail/my_order_detail_args.dart';
import 'package:tuku_shop/src/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

const _kImgThumbnailSize = 60.0;

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SdSpacingV5.s12),
      decoration: BoxDecoration(
        color: context.colorTheme.cardDefault,
        borderRadius: BorderRadius.all(Radius.circular(SdSpacingV5.s10)),
        border: Border.all(
          width: SdSpacingV5.s1,
          color: context.colorTheme.pageDefault,
        ),
      ),
      child: Column(
        children: [
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
                child: _InfoSection(
                  name: order.productName,
                  color: order.productColor.colorName,
                  quantity: order.quantity,
                ),
              ),
              SdHorizontalSpacingV5(),
              _PriceAndTagSection(
                price: order.totalPrice,
                status: order.status,
              ),
            ],
          ),
          SdVerticalSpacingV5(xRatio: 0.5),
          _ActionSection(orderId: order.id),
        ],
      ),
    );
  }
}

class _PriceAndTagSection extends StatelessWidget {
  const _PriceAndTagSection({required this.price, required this.status});
  final double price;
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SdTagV5(
          label: status.label,
          color: status.color,
          borderRadiusValue: SdSpacingV5.s8,
        ),
        SdVerticalSpacingV5(),
        Text(
          SdCurrencyFormatHelperV5.formatPrice(price),
          style: SdTextStyleV5.heading14(),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.name,
    required this.color,
    required this.quantity,
  });
  final String name;
  final String color;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: SdTextStyleV5.heading14(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SdVerticalSpacingV5(xRatio: 0.5),
        TitleContentRow(title: 'Color', content: color),
        SdVerticalSpacingV5(xRatio: 0.25),
        TitleContentRow(title: 'Quantity', content: quantity.toString()),
      ],
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SdButtonV5(
          type: SdButtonTypeV5.secondary,
          title: 'Detail',
          colorConfig: Helper.getSdButtonColorConfig(context),
          borderRadiusValue: SdSpacingV5.s8,
          buttonSize: SdButtonSizeV5.small,
          onTap: () => context.pushNamed(
            MyOrderRoutes.myOrderDetail.name,
            extra: MyOrderDetailArgs(orderId: orderId),
          ),
        ),
        SdHorizontalSpacingV5(),
        SdButtonV5(
          title: 'Tracking',
          colorConfig: Helper.getSdButtonColorConfig(context),
          borderRadiusValue: SdSpacingV5.s8,
          buttonSize: SdButtonSizeV5.small,
        ),
      ],
    );
  }
}

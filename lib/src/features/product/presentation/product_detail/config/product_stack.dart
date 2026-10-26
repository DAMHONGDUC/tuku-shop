import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/presentation/category_products/category_products_args.dart';
import 'package:tuku_shop/src/features/product/presentation/category_products/category_products_screen.dart';

import '../../product_reviews/product_reviews_screen.dart';
import '../product_detail_args.dart';
import '../product_detail_screen.dart';

class ProductStack {
  static final List<GoRoute> routes = [
    SdGoRouteV5(
      path: ProductRoutes.productDetail.path,
      name: ProductRoutes.productDetail.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        final args =
            state.extra as ProductDetailArgs? ??
            ProductDetailArgs(productId: state.uri.queryParameters['id']!);
        return ProductDetailScreen(args: args);
      },
    ),
    SdGoRouteV5(
      path: ProductRoutes.productReviews.path,
      name: ProductRoutes.productReviews.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return ProductReviewsScreen(
          productId: state.uri.queryParameters['id'] ?? '',
        );
      },
    ),
    SdGoRouteV5(
      path: ProductRoutes.productList.path,
      name: ProductRoutes.productList.name,
      parentNavigatorKey: kRootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return CategoryProductsScreen(
          args: CategoryProductsArgs.fromQuery(state.uri.queryParameters),
        );
      },
    ),
  ];
}

import 'package:system_design/index.dart';

class ProductRoutes {
  static const SdRouterV5 productDetail = SdRouterV5(
    name: 'product-detail',
    path: '/product-detail',
    fullPath: '/product-detail',
  );

  /// A category, a tag or a sale list; pushed above the tabs.
  static const SdRouterV5 productList = SdRouterV5(
    name: 'product-list',
    path: '/products',
    fullPath: '/products',
  );

  /// Every review of one product, under the product page's bar and dock.
  static const SdRouterV5 productReviews = SdRouterV5(
    name: 'product-reviews',
    path: '/product-reviews',
    fullPath: '/product-reviews',
  );

  /// Location of [productReviews] for [productId].
  static String productReviewsLocation(String productId) => Uri(
    path: productReviews.fullPath,
    queryParameters: {'id': productId},
  ).toString();

  /// Location of [productDetail] for [productId]; usable from any feature.
  static String productDetailLocation(String productId) => Uri(
    path: productDetail.fullPath,
    queryParameters: {'id': productId},
  ).toString();

  /// Location of [productList]; filters travel as query parameters so any
  /// feature can link to a list without importing the product feature.
  static String productListLocation({
    required String title,
    String? categoryId,
    String? tag,
    String? sellerId,
    bool onSaleOnly = false,
  }) {
    return Uri(
      path: productList.fullPath,
      queryParameters: {
        'title': title,
        'categoryId': ?categoryId,
        'tag': ?tag,
        'seller': ?sellerId,
        if (onSaleOnly) 'sale': '1',
      },
    ).toString();
  }
}

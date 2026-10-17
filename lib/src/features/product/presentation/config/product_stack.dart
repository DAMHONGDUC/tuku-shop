import 'package:go_router/go_router.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../product_detail/product_detail_screen.dart';
import '../product_list/product_list_screen.dart';
import '../reviews/product_reviews_screen.dart';
import '../search/search_screen.dart';
import '../shop/shop_screen.dart';
import '../wishlist/wishlist_screen.dart';

class ProductStack {
  static final List<RouteBase> shopTabRoutes = <RouteBase>[
    GoRoute(
      path: AppRoutes.shop.path,
      name: AppRoutes.shop.name,
      builder: (_, _) => const ShopScreen(),
    ),
  ];

  static final List<RouteBase> wishlistTabRoutes = <RouteBase>[
    GoRoute(
      path: AppRoutes.wishlist.path,
      name: AppRoutes.wishlist.name,
      builder: (_, _) => const WishlistScreen(),
    ),
  ];

  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: AppRoutes.search.path,
      name: AppRoutes.search.name,
      builder: (_, _) => const SearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.productList.path,
      name: AppRoutes.productList.name,
      builder: (_, GoRouterState state) => ProductListScreen(
        args: ProductListArgs.fromQuery(state.uri.queryParameters),
      ),
    ),
    GoRoute(
      path: AppRoutes.productDetail.path,
      name: AppRoutes.productDetail.name,
      builder: (_, GoRouterState state) => ProductDetailScreen(
        productId: state.pathParameters[AppRoutes.idParam]!,
        args: state.extra is ProductDetailArgs
            ? state.extra! as ProductDetailArgs
            : null,
      ),
      routes: <RouteBase>[
        GoRoute(
          path: 'reviews',
          name: AppRoutes.productReviews.name,
          builder: (_, GoRouterState state) => ProductReviewsScreen(
            productId: state.pathParameters[AppRoutes.idParam]!,
          ),
        ),
      ],
    ),
  ];
}

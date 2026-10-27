import 'package:system_design/index.dart';

class HomeRoutes {
  static const SdRouterV5 home = SdRouterV5(
    name: 'home',
    path: '/home',
    fullPath: '/home',
  );

  static final SdRouterV5 search = SdRouterV5(
    name: 'search',
    path: 'search',
    fullPath: '${home.fullPath}/search',
  );

  /// [search], opening its filter sheet straight away when [filters], and
  /// already narrowed to [categoryId] when given.
  static String searchLocation({bool filters = false, String? categoryId}) =>
      Uri(
        path: search.fullPath,
        queryParameters: {if (filters) 'filters': '1', 'category': ?categoryId},
      ).toString();
}

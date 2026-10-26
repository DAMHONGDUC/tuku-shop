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

  /// [search], opening its filter sheet straight away when [filters].
  static String searchLocation({bool filters = false}) => Uri(
    path: search.fullPath,
    queryParameters: {if (filters) 'filters': '1'},
  ).toString();
}

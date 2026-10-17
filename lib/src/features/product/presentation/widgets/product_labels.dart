import 'package:flutter/widgets.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Localized names for the catalogue's enums.
extension ProductLabels on BuildContext {
  String sortLabel(ProductSort sort) => switch (sort) {
    ProductSort.recommended => loc.sort_recommended,
    ProductSort.newest => loc.sort_newest,
    ProductSort.priceLowHigh => loc.sort_price_low,
    ProductSort.priceHighLow => loc.sort_price_high,
    ProductSort.topRated => loc.sort_top_rated,
    ProductSort.bestSelling => loc.sort_best_selling,
  };

  String genderLabel(Gender gender) => switch (gender) {
    Gender.all => loc.gender_all,
    Gender.men => loc.gender_men,
    Gender.women => loc.gender_women,
    Gender.unisex => loc.gender_unisex,
  };
}

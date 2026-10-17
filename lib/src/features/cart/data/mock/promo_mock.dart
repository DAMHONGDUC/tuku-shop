import 'package:tuku_shop/src/features/cart/data/models/promo_model.dart';

abstract final class PromoMock {
  static const List<PromoModel> codes = <PromoModel>[
    PromoModel(code: 'TUKU10', percentOff: 0.10),
    PromoModel(code: 'WELCOME20', percentOff: 0.20, minSubtotal: 100),
    PromoModel(code: 'FREESHIP', freeShipping: true),
  ];
}

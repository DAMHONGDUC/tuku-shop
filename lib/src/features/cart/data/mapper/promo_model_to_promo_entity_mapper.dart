import 'package:tuku_shop/src/features/cart/data/models/promo_model.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

class PromoModelToPromoEntityMapper {
  const PromoModelToPromoEntityMapper._();

  static PromoEntity toEntity(PromoModel model) => PromoEntity(
    code: model.code ?? '',
    percentOff: model.percentOff ?? 0,
    freeShipping: model.freeShipping ?? false,
    minSubtotal: model.minSubtotal ?? 0,
  );
}

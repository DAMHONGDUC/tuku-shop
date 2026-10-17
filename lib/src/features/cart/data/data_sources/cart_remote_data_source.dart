import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/mock/promo_mock.dart';
import 'package:tuku_shop/src/features/cart/data/models/promo_model.dart';

/// Validates promo codes the way a pricing service would.
abstract class CartRemoteDataSource {
  Future<PromoModel> redeem(String code, {required double subtotal});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl();

  @override
  Future<PromoModel> redeem(String code, {required double subtotal}) async {
    await MockLatency.normal();

    final PromoModel? promo = PromoMock.codes.firstWhereOrNull(
      (PromoModel p) => p.code == code,
    );

    if (promo == null) {
      throw const ValidationException(FailureCodes.invalidPromo);
    }
    if (subtotal < (promo.minSubtotal ?? 0)) {
      throw const ValidationException(FailureCodes.promoMinimum);
    }

    return promo;
  }
}

import 'package:tuku_shop/src/features/seller/data/models/seller_model.dart';
import 'package:tuku_shop/src/features/seller/domain/entities/seller.dart';

class SellerModelToSellerMapper {
  const SellerModelToSellerMapper._();

  static Seller toEntity(SellerModel model) {
    return Seller(
      id: model.id ?? '',
      name: model.name ?? '',
      colorHex: model.colorHex ?? '#504EB7',
      rating: model.rating ?? 0,
      followerCount: model.followerCount ?? 0,
      responseRate: model.responseRate ?? 0,
      location: model.location ?? '',
      isOfficial: model.isOfficial ?? false,
    );
  }
}

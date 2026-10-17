import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/banner/data/models/banner_model.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';

class BannerModelToBannerEntityMapper {
  const BannerModelToBannerEntityMapper._();

  static BannerEntity toEntity(BannerModel model) => BannerEntity(
    id: model.id ?? '',
    eyebrow: model.eyebrow ?? '',
    title: model.title ?? '',
    subtitle: model.subtitle ?? '',
    image: model.image ?? '',
    target: ProductListArgs.fromQuery(model.target ?? <String, String>{}),
  );
}

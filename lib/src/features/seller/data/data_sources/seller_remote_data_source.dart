import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/seller/data/mock/seller_mock.dart';
import 'package:tuku_shop/src/features/seller/data/models/seller_model.dart';

abstract class SellerRemoteDataSource {
  Future<SellerModel> getSeller(String id);

  Future<List<SellerModel>> getSellersByIds(List<String> ids);
}

class SellerRemoteDataSourceImpl implements SellerRemoteDataSource {
  const SellerRemoteDataSourceImpl();

  @override
  Future<SellerModel> getSeller(String id) async {
    await MockLatency.wait();
    final seller = SellerMock.sellers.firstWhereOrNull((s) => s.id == id);
    if (seller == null) throw const ServerException('Seller not found');
    return seller;
  }

  @override
  Future<List<SellerModel>> getSellersByIds(List<String> ids) async {
    await MockLatency.wait();
    return [
      for (final id in ids)
        ?SellerMock.sellers.firstWhereOrNull((s) => s.id == id),
    ];
  }
}

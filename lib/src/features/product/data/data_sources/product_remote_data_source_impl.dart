import 'package:collection/collection.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/data/models/product_data_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/mock/product_mock.dart';
import 'package:tuku_shop/src/features/product/data/models/recommend_products_data_model.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:system_design/index.dart';

import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl();

  @override
  Future<RecommendProductsDataModel> getRecommendProducts({
    required GetRecommendProjectFilterParams params,
  }) async {
    try {
      await SdHelperV5.delayLoading();

      final allProducts = ProductMock.products;

      final startIndex = (params.pageNumber - 1) * params.itemCount;

      if (startIndex >= allProducts.length) {
        return RecommendProductsDataModel(
          items: [],
          totalPage: (allProducts.length / params.itemCount).ceil(),
          currentPage: params.pageNumber,
          totalRecord: allProducts.length,
        );
      }

      final endIndex = (startIndex + params.itemCount).clamp(
        0,
        allProducts.length,
      );

      return RecommendProductsDataModel(
        items: allProducts.sublist(startIndex, endIndex),
        totalPage: (allProducts.length / params.itemCount).ceil(),
        currentPage: params.pageNumber,
        totalRecord: allProducts.length,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductsDataModel> searchProducts({
    required SearchProductsFilterParams params,
  }) async {
    try {
      await SdHelperV5.delayLoading();

      final keyword = params.keyword.trim().toLowerCase();
      final matched = keyword.isEmpty
          ? ProductMock.products
          : ProductMock.products
                .where((e) => (e.name ?? '').toLowerCase().contains(keyword))
                .toList();

      final total = matched.length;
      final totalPage = total == 0 ? 0 : (total / params.itemCount).ceil();
      final start = (params.page - 1) * params.itemCount;
      final end = (start + params.itemCount).clamp(0, total);

      final products = start < total
          ? matched.sublist(start, end)
          : <ProductModel>[];

      return ProductsDataModel(
        items: products,
        totalPage: totalPage,
        currentPage: params.page,
        totalRecord: total,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductDetail({required String productId}) async {
    try {
      await SdHelperV5.delayLoading();

      final product = ProductMock.products.firstWhereOrNull(
        (e) => e.id == productId,
      );

      if (product == null) throw ServerException();
      return product;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getRelatedProducts({
    required String productId,
    int? limit,
  }) async {
    try {
      await SdHelperV5.delayLoading();

      final related = ProductMock.products
          .where((e) => e.id != productId)
          .toList();

      if (limit != null && limit < related.length) {
        return related.sublist(0, limit);
      }

      return related;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

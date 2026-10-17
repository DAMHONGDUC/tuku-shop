import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_rail_state.dart';

/// Loads one page of products for a home rail — new arrivals, best sellers.
class ProductRailController extends Cubit<ProductRailState> {
  ProductRailController(this._getProducts) : super(const ProductRailState());

  final GetProductsUsecase _getProducts;

  Future<void> load(ProductQuery query) async {
    emit(const ProductRailState());

    final Either<Failure, ProductPage> result = await _getProducts(query);

    result.fold(
      (Failure _) => emit(const ProductRailState(status: LoadStatus.failure)),
      (ProductPage page) => emit(
        ProductRailState(status: LoadStatus.success, products: page.items),
      ),
    );
  }
}

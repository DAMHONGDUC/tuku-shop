import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'related_products_state.dart';

class RelatedProductsController extends Cubit<RelatedProductsState> {
  final GetRelatedProductUsecase _getRelatedProductUsecase;

  RelatedProductsController(this._getRelatedProductUsecase)
    : super(RelatedProductsInitial());

  Future<void> getData({required String productId}) async {
    emit(RelatedProductsLoadingState());

    final result = await _getRelatedProductUsecase.call(
      GetRelatedProductParams(productId: productId, limit: 8),
    );

    result.fold(
      (failure) {
        emit(RelatedProductsErrorState(errorMsg: ''));
      },
      (r) {
        emit(RelatedProductsLoadedState(products: r));
      },
    );
  }
}

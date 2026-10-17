import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'product_detail_state.dart';

class ProductDetailController extends Cubit<ProductDetailState> {
  ProductDetailController({
    required GetProductDetailUsecase getProductDetail,
    required GetRelatedProductsUsecase getRelatedProducts,
    required GetProductReviewsUsecase getReviews,
    required AddToCartUsecase addToCart,
  }) : _getProductDetail = getProductDetail,
       _getRelatedProducts = getRelatedProducts,
       _getReviews = getReviews,
       _addToCart = addToCart,
       super(const ProductDetailState());

  final GetProductDetailUsecase _getProductDetail;
  final GetRelatedProductsUsecase _getRelatedProducts;
  final GetProductReviewsUsecase _getReviews;
  final AddToCartUsecase _addToCart;

  Future<void> load(String id) async {
    emit(const ProductDetailState());

    final Either<Failure, ProductEntity> result = await _getProductDetail(id);

    await result.fold(
      (Failure _) async =>
          emit(const ProductDetailState(status: LoadStatus.failure)),
      (ProductEntity product) async {
        emit(
          ProductDetailState(
            status: LoadStatus.success,
            product: product,
            // One-size products need no choice.
            size: product.sizes.length == 1 ? product.sizes.first : null,
          ),
        );
        await Future.wait(<Future<void>>[_loadRelated(id), _loadReviews(id)]);
      },
    );
  }

  Future<void> _loadRelated(String id) async {
    final Either<Failure, List<ProductEntity>> result =
        await _getRelatedProducts(id);
    result.fold(
      (Failure _) {},
      (List<ProductEntity> related) => emit(state.copyWith(related: related)),
    );
  }

  Future<void> _loadReviews(String id) async {
    final Either<Failure, ReviewsPage> result = await _getReviews(
      ReviewsParams(productId: id),
    );
    result.fold(
      (Failure _) {},
      (ReviewsPage reviews) => emit(state.copyWith(reviews: () => reviews)),
    );
  }

  void selectColor(int index) => emit(state.copyWith(colorIndex: index));

  void selectSize(String size) => emit(state.copyWith(size: () => size));

  void setQuantity(int quantity) => emit(state.copyWith(quantity: quantity));

  /// False, and a nudge at the size picker, when no size is chosen yet.
  Future<bool> addToBag() async {
    final ProductEntity? product = state.product;

    if (product == null) return false;

    if (state.size == null) {
      emit(state.copyWith(sizeNudge: state.sizeNudge + 1));
      return false;
    }

    emit(state.copyWith(adding: true));

    final ProductColor color = product.colors[state.colorIndex];
    final Either<Failure, CartEntity> result = await _addToCart(
      AddToCartParams(
        productId: product.id,
        name: product.name,
        brand: product.brand,
        image: color.images.first,
        color: color.name,
        size: state.size!,
        unitPrice: product.price,
        compareAtPrice: product.compareAtPrice,
        quantity: state.quantity,
      ),
    );

    emit(state.copyWith(adding: false, addedCount: state.addedCount + 1));
    return result.isRight();
  }
}

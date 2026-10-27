import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

class GetProductReviewsUsecase
    implements UseCase<ReviewsPage, ProductReviewsParams> {
  final ProductRepository repository;

  GetProductReviewsUsecase(this.repository);

  @override
  Future<Either<Failure, ReviewsPage>> call(ProductReviewsParams params) {
    return repository.getProductReviews(
      productId: params.productId,
      page: params.page,
      pageSize: params.pageSize,
      colorName: params.colorName,
      size: params.size,
    );
  }
}

class ProductReviewsParams extends Equatable {
  final String productId;
  final int page;
  final int pageSize;

  /// Only reviews of this variation, when set.
  final String? colorName;
  final String? size;

  const ProductReviewsParams({
    required this.productId,
    this.page = 1,
    this.pageSize = 5,
    this.colorName,
    this.size,
  });

  @override
  List<Object?> get props => [productId, page, pageSize, colorName, size];
}

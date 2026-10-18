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
    );
  }
}

class ProductReviewsParams extends Equatable {
  final String productId;
  final int page;
  final int pageSize;

  const ProductReviewsParams({
    required this.productId,
    this.page = 1,
    this.pageSize = 5,
  });

  @override
  List<Object?> get props => [productId, page, pageSize];
}

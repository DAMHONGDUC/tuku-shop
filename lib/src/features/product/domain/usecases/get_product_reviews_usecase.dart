import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/reviews_page.dart';
import '../repositories/product_repository.dart';

class ReviewsParams extends Equatable {
  const ReviewsParams({required this.productId, this.page = 1});

  final String productId;
  final int page;

  @override
  List<Object> get props => <Object>[productId, page];
}

class GetProductReviewsUsecase implements UseCase<ReviewsPage, ReviewsParams> {
  GetProductReviewsUsecase(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, ReviewsPage>> call(ReviewsParams params) =>
      repository.getReviews(productId: params.productId, page: params.page);
}

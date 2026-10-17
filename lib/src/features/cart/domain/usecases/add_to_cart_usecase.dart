import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartParams extends Equatable {
  const AddToCartParams({
    required this.productId,
    required this.name,
    required this.brand,
    required this.image,
    required this.color,
    required this.size,
    required this.unitPrice,
    this.compareAtPrice,
    this.quantity = 1,
  });

  final String productId;
  final String name;
  final String brand;
  final String image;
  final String color;
  final String size;
  final double unitPrice;
  final double? compareAtPrice;
  final int quantity;

  @override
  List<Object?> get props => <Object?>[
    productId,
    name,
    brand,
    image,
    color,
    size,
    unitPrice,
    compareAtPrice,
    quantity,
  ];
}

class AddToCartUsecase implements UseCase<CartEntity, AddToCartParams> {
  AddToCartUsecase(this.repository);

  final CartRepository repository;

  @override
  Future<Either<Failure, CartEntity>> call(AddToCartParams params) =>
      repository.add(
        CartItemEntity(
          id: '${params.productId}|${params.color}|${params.size}',
          productId: params.productId,
          name: params.name,
          brand: params.brand,
          image: params.image,
          color: params.color,
          size: params.size,
          unitPrice: params.unitPrice,
          compareAtPrice: params.compareAtPrice,
          quantity: params.quantity,
        ),
      );
}

import 'package:tuku_shop/src/core/core.dart';
import 'package:equatable/equatable.dart';

class ReviewAsset extends Equatable {
  final String url;
  final AssetType type;

  const ReviewAsset({required this.url, required this.type});

  @override
  List<Object?> get props => [url, type];
}

class ReviewComment extends Equatable {
  final String id;
  final String userName;
  final String comment;
  final double rating;
  final String createdAt;
  final List<ReviewAsset> assets;

  /// The variation the reviewer bought; empty when unknown.
  final String colorName;
  final String size;

  const ReviewComment({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.createdAt,
    this.assets = const [],
    this.colorName = '',
    this.size = '',
  });

  @override
  List<Object?> get props => [
    id,
    userName,
    comment,
    rating,
    createdAt,
    assets,
    colorName,
    size,
  ];
}

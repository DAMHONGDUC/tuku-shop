import 'package:tuku_shop/src/core/core.dart';

import 'package:equatable/equatable.dart';

class BannerItem extends Equatable {
  final String imageUrl;
  final String tag;
  final BannerTagType tagType;
  final String title;
  final String subtitle;
  final String price;
  final String contentColor;
  final int id;

  /// Category the banner opens; empty for none.
  final String categoryId;

  const BannerItem({
    required this.imageUrl,
    required this.tag,
    required this.tagType,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.contentColor,
    required this.id,
    this.categoryId = '',
  });

  @override
  List<Object?> get props => [
    imageUrl,
    tag,
    tagType,
    title,
    subtitle,
    price,
    contentColor,
    id,
    categoryId,
  ];
}

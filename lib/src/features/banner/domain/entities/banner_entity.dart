import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

class BannerEntity extends Equatable {
  const BannerEntity({
    required this.id,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.target,
  });

  final String id;

  /// The small line above the title — "NEW SEASON", "UP TO 40% OFF".
  final String eyebrow;
  final String title;
  final String subtitle;
  final String image;

  /// What tapping the banner opens.
  final ProductListArgs target;

  @override
  List<Object> get props => <Object>[
    id,
    eyebrow,
    title,
    subtitle,
    image,
    target,
  ];
}

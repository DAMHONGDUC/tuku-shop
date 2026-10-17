import 'package:equatable/equatable.dart';

class ProductColor extends Equatable {
  const ProductColor({
    required this.name,
    required this.hex,
    required this.images,
  });

  final String name;

  /// `#RRGGBB`. Kept as text so the domain stays free of Flutter's `Color`.
  final String hex;
  final List<String> images;

  @override
  List<Object> get props => <Object>[name, hex, images];
}

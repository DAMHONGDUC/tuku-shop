import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.productCount,
  });

  final String id;
  final String name;
  final String image;
  final int productCount;

  @override
  List<Object> get props => <Object>[id, name, image, productCount];
}

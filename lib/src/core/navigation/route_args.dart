import 'package:equatable/equatable.dart';

import '../enums/gender.dart';
import '../enums/product_sort.dart';

/// What the product list screen shows, carried in the query string so the
/// route survives a cold start and can be deep linked.
class ProductListArgs extends Equatable {
  const ProductListArgs({
    this.title,
    this.categoryId,
    this.gender = Gender.all,
    this.sort = ProductSort.recommended,
    this.onSaleOnly = false,
    this.newOnly = false,
  });

  factory ProductListArgs.fromQuery(Map<String, String> query) =>
      ProductListArgs(
        title: query['title'],
        categoryId: query['category'],
        gender: Gender.values.firstWhere(
          (Gender e) => e.name == query['gender'],
          orElse: () => Gender.all,
        ),
        sort: ProductSort.values.firstWhere(
          (ProductSort e) => e.name == query['sort'],
          orElse: () => ProductSort.recommended,
        ),
        onSaleOnly: query['sale'] == '1',
        newOnly: query['new'] == '1',
      );

  final String? title;
  final String? categoryId;
  final Gender gender;
  final ProductSort sort;
  final bool onSaleOnly;
  final bool newOnly;

  Map<String, String> toQuery() => <String, String>{
    'title': ?title,
    'category': ?categoryId,
    if (gender != Gender.all) 'gender': gender.name,
    if (sort != ProductSort.recommended) 'sort': sort.name,
    if (onSaleOnly) 'sale': '1',
    if (newOnly) 'new': '1',
  };

  @override
  List<Object?> get props => <Object?>[
    title,
    categoryId,
    gender,
    sort,
    onSaleOnly,
    newOnly,
  ];
}

/// The optional half of a product detail route: which [heroTag] the photo
/// flies from. The product id itself is in the path.
class ProductDetailArgs {
  const ProductDetailArgs({this.heroTag});

  final String? heroTag;
}

/// Opens the address form to edit an existing address, or to add one when
/// [addressId] is null. [selectAfterSave] is set by checkout, which wants the
/// new address picked.
class AddressFormArgs {
  const AddressFormArgs({this.addressId});

  final String? addressId;
}

import 'package:tuku_shop/src/features/category/data/models/category_model.dart';

const _kCatalogPath = 'assets/images/catalog/';

class CategoryMock {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'women-tops',
      name: 'Tops',
      imageUrl: '${_kCatalogPath}women-tops/wt3_1.jpg',
      numOfProduct: 5,
      colorHex: '#F6E7E1',
    ),
    CategoryModel(
      id: 'women-dresses',
      name: 'Dresses',
      imageUrl: '${_kCatalogPath}women-dresses/wd1_2.jpg',
      numOfProduct: 5,
      colorHex: '#F3E6EE',
    ),
    CategoryModel(
      id: 'women-skirts',
      name: 'Skirts',
      imageUrl: '${_kCatalogPath}women-skirts/ws1_2.jpg',
      numOfProduct: 4,
      colorHex: '#EFE9F6',
    ),
    CategoryModel(
      id: 'men-tshirts',
      name: 'T-shirts',
      imageUrl: '${_kCatalogPath}men-tshirts/mt1_1.jpg',
      numOfProduct: 5,
      colorHex: '#E6EEF6',
    ),
    CategoryModel(
      id: 'men-shirts',
      name: 'Shirts',
      imageUrl: '${_kCatalogPath}men-shirts/ms1_2.jpg',
      numOfProduct: 5,
      colorHex: '#E3F0F2',
    ),
    CategoryModel(
      id: 'jeans',
      name: 'Jeans',
      imageUrl: '${_kCatalogPath}jeans/jn1_1.jpg',
      numOfProduct: 5,
      colorHex: '#E1E8F3',
    ),
    CategoryModel(
      id: 'trousers',
      name: 'Trousers',
      imageUrl: '${_kCatalogPath}trousers/tr1_1.jpg',
      numOfProduct: 5,
      colorHex: '#EEF0E2',
    ),
    CategoryModel(
      id: 'hoodies',
      name: 'Hoodies',
      imageUrl: '${_kCatalogPath}hoodies/hd3_1.jpg',
      numOfProduct: 5,
      colorHex: '#F8EADF',
    ),
    CategoryModel(
      id: 'jackets',
      name: 'Outerwear',
      imageUrl: '${_kCatalogPath}jackets/jk3_1.jpg',
      numOfProduct: 5,
      colorHex: '#F2ECE3',
    ),
    CategoryModel(
      id: 'activewear',
      name: 'Activewear',
      imageUrl: '${_kCatalogPath}activewear/ac2_2.jpg',
      numOfProduct: 5,
      colorHex: '#E4F2EA',
    ),
    CategoryModel(
      id: 'kids',
      name: 'Kids',
      imageUrl: '${_kCatalogPath}kids/kd2_1.jpg',
      numOfProduct: 5,
      colorHex: '#FFF4D9',
    ),
    CategoryModel(
      id: 'shoes',
      name: 'Shoes',
      imageUrl: '${_kCatalogPath}shoes/sh4_1.jpg',
      numOfProduct: 5,
      colorHex: '#ECECEC',
    ),
    CategoryModel(
      id: 'bags',
      name: 'Bags',
      imageUrl: '${_kCatalogPath}bags/bg2_1.jpg',
      numOfProduct: 5,
      colorHex: '#F5EBE0',
    ),
    CategoryModel(
      id: 'accessories',
      name: 'Accessories',
      imageUrl: '${_kCatalogPath}accessories/as5_1.jpg',
      numOfProduct: 12,
      colorHex: '#EAF1F4',
    ),
  ];
}

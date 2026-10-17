import 'package:tuku_shop/src/features/product/data/mock/product_description_mock.dart';
import 'package:tuku_shop/src/features/product/data/mock/review_comment_mock.dart';
import 'package:tuku_shop/src/features/product/data/models/description_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_color_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/product_size_model.dart';
import 'package:system_design/index.dart';

final kMockProductPath = 'assets/images/product/';

class ProductMock {
  static List<ProductSizeModel> generateProductSizes() {
    final sizeNames = ['S', 'M', 'L', 'XL', 'XXL'];

    return sizeNames.map((e) => ProductSizeModel(id: e, name: e)).toList();
  }

  static final List<ProductModel> products = [
    ProductModel(
      id: "1",
      name: 'Margaux Leather',
      brand: 'Handbag',
      price: 195.00,
      imageUrl: '${kMockProductPath}p1_1.png',
      purchaserCount: 120,
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p1_1.png',
        ),
        ProductColorModel(
          colorCode: '#DAA520',
          colorName: 'Orche',
          imageUrl: '${kMockProductPath}p1_2.png',
        ),
        ProductColorModel(
          colorCode: '#000000',
          colorName: 'Noir',
          imageUrl: '${kMockProductPath}p1_3.png',
        ),
        ProductColorModel(
          colorCode: '#8B4513',
          colorName: 'Mocha',
          imageUrl: '${kMockProductPath}p1_4.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p1_2.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "2",
      name: 'Vancouver Crossbody',
      brand: 'Bag',
      price: 143.45,
      imageUrl: '${kMockProductPath}p2_2.png',
      purchaserCount: 85,
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p2_1.png',
        ),
        ProductColorModel(
          colorCode: '#DAA520',
          colorName: 'Orche',
          imageUrl: '${kMockProductPath}p2_2.png',
        ),
        ProductColorModel(
          colorCode: '#000000',
          colorName: 'Noir',
          imageUrl: '${kMockProductPath}p2_3.png',
        ),
        ProductColorModel(
          colorCode: '#8B4513',
          colorName: 'Mocha',
          imageUrl: '${kMockProductPath}p2_4.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p2_3.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "3",
      name: 'Shoulder Bag Beach',
      brand: 'Tote Bag Straw bags',
      price: 195.00,
      imageUrl: '${kMockProductPath}p3_1.png',
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p3_1.png',
        ),
      ],
      purchaserCount: 42,
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p3_1.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "4",
      name: 'Everyday Leather',
      brand: 'Bag',
      price: 143.45,
      imageUrl: '${kMockProductPath}p4_3.png',
      purchaserCount: 97,
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p4_3.png',
        ),
        ProductColorModel(
          colorCode: '#800020',
          colorName: 'Burgundy',
          imageUrl: '${kMockProductPath}p4_2.png',
        ),
        ProductColorModel(
          colorCode: '#1F2937',
          colorName: 'Navy',
          imageUrl: '${kMockProductPath}p4_3.png',
        ),
        ProductColorModel(
          colorCode: '#9CA3AF',
          colorName: 'Ash',
          imageUrl: '${kMockProductPath}p4_4.png',
        ),
        ProductColorModel(
          colorCode: '#F5F5DC',
          colorName: 'Cream',
          imageUrl: '${kMockProductPath}p4_5.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p4_5.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "5",
      name: 'Retro Kaleidoscope Print Knit V-neck Pullover',
      brand: 'Sweater',
      price: 195.00,
      imageUrl: '${kMockProductPath}p5_1.png',
      purchaserCount: 60,
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p5_1.png'],
      ),
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p5_1.png',
        ),
      ],
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "6",
      name: 'Melanie Suede',
      brand: 'Bag',
      price: 143.45,
      imageUrl: '${kMockProductPath}p6_1.png',
      purchaserCount: 73,
      productColors: [
        ProductColorModel(
          colorCode: '#8B4513',
          colorName: 'Brown',
          imageUrl: '${kMockProductPath}p6_1.png',
        ),
        ProductColorModel(
          colorCode: '#D2B48C',
          colorName: 'Light Brown',
          imageUrl: '${kMockProductPath}p6_2.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p6_2.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "7",
      name: 'Aria Canvas Tote',
      brand: 'Tote Bag',
      price: 89.90,
      imageUrl: '${kMockProductPath}p2_1.png',
      purchaserCount: 54,
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p2_1.png',
        ),
        ProductColorModel(
          colorCode: '#DAA520',
          colorName: 'Orche',
          imageUrl: '${kMockProductPath}p2_2.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p2_3.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "8",
      name: 'Nomad Weekender',
      brand: 'Duffel Bag',
      price: 210.00,
      imageUrl: '${kMockProductPath}p4_1.png',
      purchaserCount: 38,
      productColors: [
        ProductColorModel(
          colorCode: '#1F2937',
          colorName: 'Navy',
          imageUrl: '${kMockProductPath}p4_3.png',
        ),
        ProductColorModel(
          colorCode: '#9CA3AF',
          colorName: 'Ash',
          imageUrl: '${kMockProductPath}p4_4.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p4_5.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "9",
      name: 'Luna Clutch',
      brand: 'Clutch',
      price: 65.50,
      imageUrl: '${kMockProductPath}p1_2.png',
      purchaserCount: 29,
      productColors: [
        ProductColorModel(
          colorCode: '#000000',
          colorName: 'Noir',
          imageUrl: '${kMockProductPath}p1_3.png',
        ),
        ProductColorModel(
          colorCode: '#8B4513',
          colorName: 'Mocha',
          imageUrl: '${kMockProductPath}p1_4.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p1_1.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "10",
      name: 'Heritage Satchel',
      brand: 'Bag',
      price: 158.00,
      imageUrl: '${kMockProductPath}p6_1.png',
      purchaserCount: 46,
      productColors: [
        ProductColorModel(
          colorCode: '#8B4513',
          colorName: 'Brown',
          imageUrl: '${kMockProductPath}p6_1.png',
        ),
        ProductColorModel(
          colorCode: '#D2B48C',
          colorName: 'Light Brown',
          imageUrl: '${kMockProductPath}p6_2.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p6_1.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "11",
      name: 'Coastal Straw Tote',
      brand: 'Straw Bag',
      price: 72.00,
      imageUrl: '${kMockProductPath}p3_1.png',
      purchaserCount: 21,
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p3_1.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p3_1.png'],
      ),
      productSizes: generateProductSizes(),
    ),
    ProductModel(
      id: "12",
      name: 'Cloudknit Cardigan',
      brand: 'Sweater',
      price: 128.00,
      imageUrl: '${kMockProductPath}p5_1.png',
      purchaserCount: 33,
      productColors: [
        ProductColorModel(
          colorCode: '#2C2C2C',
          colorName: 'Onyx',
          imageUrl: '${kMockProductPath}p5_1.png',
        ),
      ],
      reviewComments: ReviewCommentMock.generateRandomReviews(
        SdHelperV5.randomInt(min: 100, max: 500),
      ),
      averageRating: SdHelperV5.randomDouble(min: 3, max: 5),
      description: DescriptionModel(
        content: ProductDescriptionMock.generateRandomDescription(),
        images: ['${kMockProductPath}p5_1.png'],
      ),
      productSizes: generateProductSizes(),
    ),
  ];
}

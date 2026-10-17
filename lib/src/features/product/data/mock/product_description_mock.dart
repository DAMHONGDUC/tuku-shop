import 'dart:math';

class ProductDescriptionMock {
  // Fixed seed: the same text on every launch.
  static final _random = Random(11);

  static final _sentences = [
    'This product is made from high-quality materials, ensuring durability and longevity.',
    'Designed with user comfort in mind, it offers an excellent experience for daily use.',
    'Its sleek and modern design makes it suitable for any style or occasion.',
    'The product is lightweight and portable, easy to carry wherever you go.',
    'Eco-friendly manufacturing processes were used, making it safe for the environment.',
    'Attention to detail is evident in every part of this product.',
    'Multiple color options allow you to choose the one that fits your taste.',
    'Perfect as a gift, it will delight anyone who receives it.',
    'Maintenance is simple, ensuring the product stays in top condition.',
    'Innovative design features set this product apart from others.',
    'Its versatility allows it to be used in various situations effectively.',
    'The texture feels premium and comfortable to touch.',
    'Reliable performance guarantees customer satisfaction over time.',
    'It offers great value for its price, combining quality and affordability.',
    'Limited edition design adds exclusivity and uniqueness.',
  ];

  static String generateRandomDescription() {
    final lines = <String>[];
    final sentenceCount = 10 + _random.nextInt(5);

    for (var i = 0; i < sentenceCount; i++) {
      lines.add(_sentences[_random.nextInt(_sentences.length)]);
    }

    return lines.join(' ');
  }
}

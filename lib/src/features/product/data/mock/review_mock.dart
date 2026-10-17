import 'dart:math';

import 'package:tuku_shop/src/features/product/data/models/product_model.dart';
import 'package:tuku_shop/src/features/product/data/models/review_model.dart';

/// Reviews are generated per product from a seed of its id, so a product
/// shows the same reviews on every visit and every launch.
abstract final class ReviewMock {
  static const List<String> _authors = <String>[
    'Emma Collins', 'Liam Carter', 'Sofia Nguyen', 'Noah Bennett',
    'Mia Tran', 'Lucas Rivera', 'Chloe Kim', 'Ethan Brooks',
    'Ava Pham', 'Oliver Grant', 'Isabella Le', 'James Hall',
    'Harper Vo', 'Benjamin Cole', 'Zoe Hoang', 'Daniel Park',
  ];

  static const List<({int rating, String title, String comment})> _texts =
      <({int rating, String title, String comment})>[
        (rating: 5, title: 'Fits like a dream', comment: 'True to size and the fabric feels premium. I wore it straight out of the box for a long run and it stayed comfortable the whole way.'),
        (rating: 5, title: 'My new favourite', comment: 'Bought one, came back for two more colours. Washes really well and keeps its shape.'),
        (rating: 4, title: 'Great quality', comment: 'Lovely material and the stitching is neat. Runs slightly long in the body, so size down if you are between sizes.'),
        (rating: 5, title: 'Worth every cent', comment: 'Light, breathable and looks sharp enough to wear to the café after the gym. Delivery was quick too.'),
        (rating: 4, title: 'Comfortable all day', comment: 'Soft against the skin and does not cling. The colour is a touch darker than the photos but still beautiful.'),
        (rating: 3, title: 'Good, not perfect', comment: 'Nice design but the sleeves are a little tight for me. Customer service sorted an exchange in two days.'),
        (rating: 5, title: 'Perfect for travel', comment: 'Packs small, does not wrinkle and dries overnight. Took it on a week-long trip and wore it four times.'),
        (rating: 4, title: 'Stylish and practical', comment: 'Gets compliments every time. Pockets are deep enough for a phone, which I love.'),
        (rating: 5, title: 'Exceeded expectations', comment: 'Honestly better than brands twice the price. The fit through the shoulders is spot on.'),
        (rating: 2, title: 'Not for me', comment: 'The cut did not suit my frame, but the return was free and painless.'),
        (rating: 5, title: 'Gift success', comment: 'Bought this as a birthday present and it was a hit. The packaging felt special too.'),
        (rating: 4, title: 'Solid everyday piece', comment: 'Easy to style, holds up after many washes. Would buy again in another colour.'),
      ];

  static List<ReviewModel> forProduct(ProductModel product) {
    final String id = product.id ?? '';
    final Random random = Random(id.hashCode);
    final int count = 14 + random.nextInt(10);
    final List<String> photos = <String>[
      for (final c in product.colors ?? const []) ...(c.images ?? const <String>[]),
    ];
    final DateTime today = DateTime(2026, 10, 15);

    return List<ReviewModel>.generate(count, (int i) {
      final ({int rating, String title, String comment}) text =
          _texts[random.nextInt(_texts.length)];
      final int photoCount = i % 4 == 0 && photos.isNotEmpty
          ? 1 + random.nextInt(min(3, photos.length))
          : 0;
      final List<String> sizes = product.sizes ?? const <String>['M'];
      final List<String> colors = <String>[
        for (final c in product.colors ?? const []) c.name ?? '',
      ];

      return ReviewModel(
        id: '${id}_r$i',
        author: _authors[random.nextInt(_authors.length)],
        rating: text.rating,
        title: text.title,
        comment: text.comment,
        createdAt: today
            .subtract(Duration(days: i * 3 + random.nextInt(4)))
            .toIso8601String(),
        size: sizes[random.nextInt(sizes.length)],
        color: colors.isEmpty ? '' : colors[random.nextInt(colors.length)],
        helpfulCount: random.nextInt(40),
        photos: <String>[
          for (int p = 0; p < photoCount; p++)
            photos[random.nextInt(photos.length)],
        ],
      );
    });
  }
}

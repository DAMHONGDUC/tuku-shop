import 'dart:math';

import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';

class ReviewCommentMock {
  // Fixed seed: the same reviews on every launch.
  static final _random = Random(7);

  static const _names = [
    'Alice',
    'Bao',
    'Clara',
    'David',
    'Ethan',
    'Fiona',
    'Hana',
    'Ivy',
    'Jack',
    'Linh',
    'Mia',
    'Noah',
    'Olivia',
    'Paul',
    'Quinn',
    'Ruby',
    'Sophia',
    'Tom',
    'Uma',
    'Victor',
    'Wendy',
    'Yara',
    'Zoe',
    'Minh',
  ];

  static const _comments = [
    'Fits true to size and the fabric feels great.',
    'Even nicer in person. Already wore it twice this week.',
    'Color is exactly like the photos.',
    'Runs a little small, I would size up.',
    'Soft, comfortable and washes well.',
    'Great quality for the price.',
    'Perfect for the office and the weekend.',
    'Fast delivery and lovely packaging.',
    'The cut is really flattering.',
    'Good basic, bought it in a second color.',
    'A bit thinner than expected but still nice.',
    'Got so many compliments on this!',
    'Stitching and details feel premium.',
    'Comfortable all day, no complaints.',
  ];

  /// [count] reviews, newest first. About one in three carries one or two
  /// customer photos drawn from [photos] (the product's own pictures).
  static List<ReviewCommentModel> generateRandomReviews(
    int count, {
    List<String> photos = const [],
  }) {
    var daysAgo = 0;
    return List.generate(count, (index) {
      daysAgo += 1 + _random.nextInt(12);
      // Mostly 4–5 stars, the occasional 3.
      final rating = 3 + _random.nextDouble() * 2;
      final withPhotos = photos.isNotEmpty && _random.nextInt(3) == 0;

      return ReviewCommentModel(
        id: (index + 1).toString(),
        userName: _names[_random.nextInt(_names.length)],
        comment: _comments[_random.nextInt(_comments.length)],
        rating: double.parse(rating.toStringAsFixed(1)),
        createdAt: DateTime.utc(
          2026,
          10,
          1,
        ).subtract(Duration(days: daysAgo)).toString(),
        assets: withPhotos
            ? [
                for (var i = 0; i <= _random.nextInt(2); i++)
                  ReviewAssetModel(
                    url: photos[_random.nextInt(photos.length)],
                    type: 'image',
                  ),
              ]
            : const [],
      );
    });
  }
}

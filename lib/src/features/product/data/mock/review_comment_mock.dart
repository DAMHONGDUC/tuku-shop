import 'dart:math';

import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';

class ReviewCommentMock {
  // Fixed seed: the same reviews on every launch.
  static final _random = Random(7);

  static const _names = [
    'Linh N.',
    'Sarah K.',
    'Minh T.',
    'Olivia R.',
    'Bao P.',
    'Hana M.',
    'David L.',
    'Mai A.',
    'Ethan W.',
    'Quynh D.',
    'Sophia C.',
    'Tuan H.',
    'Clara B.',
    'Noah F.',
    'Thao V.',
    'Ruby S.',
    'Khanh L.',
    'Mia J.',
    'Jack O.',
    'Ngoc T.',
    'Zoe P.',
    'Huy B.',
    'Fiona G.',
    'An N.',
    'Victor E.',
    'Yen H.',
    'Paul D.',
    'Trang L.',
  ];

  static const _openers = [
    'Absolutely love it.',
    'Even nicer in person than in the photos.',
    'This is my third order from Tuku and the quality is consistent.',
    'Bought it on a whim and now I wear it every week.',
    'Really impressed for the price.',
    'Exactly what I was looking for.',
    'Beautiful piece, it feels much more expensive than it is.',
    'Got it as a gift for my sister and she loved it.',
    'Honestly one of my best buys this year.',
    'Simple, clean and so easy to wear.',
    'Arrived quickly and well packed.',
    'Five stars, no hesitation.',
  ];

  static const _details = [
    'The fabric is soft and has a nice weight to it.',
    'Stitching is neat and the seams feel strong.',
    'The colour is true to the pictures, maybe slightly richer.',
    'It washes well, no shrinking after three washes.',
    'The cut is really flattering and it hangs nicely.',
    'Comfortable all day, even on a long commute.',
    'Details like the buttons and lining feel premium.',
    'It breathes well, which matters a lot in this weather.',
    'Holds its shape, no bagging after a full day.',
    'The finish looks polished and expensive.',
    'Packaging was lovely, with a little thank-you note.',
    'It goes with almost everything in my wardrobe.',
  ];

  static const _critical = [
    'Nice design, but it runs a little small, so size up.',
    'Good quality, though the colour is a touch darker than the photos.',
    'Comfortable, but it creases more than I expected.',
    'Lovely fabric. Delivery took a day longer than promised.',
    'Pretty, but the sleeves are a bit long for me.',
    'Decent for the price, just not as thick as I hoped.',
  ];

  static const _heights = [152, 158, 160, 163, 165, 168, 170, 174, 178, 182];

  /// A buyer note with the size and colour they bought, when known.
  static String _context(List<String> sizes, List<String> colors) {
    final notes = <String>[
      if (sizes.length > 1)
        'I am ${_heights[_random.nextInt(_heights.length)]} cm and took '
            '${sizes[_random.nextInt(sizes.length)]}, fits perfectly.',
      if (colors.isNotEmpty)
        'Ordered it in ${colors[_random.nextInt(colors.length)]} and might '
            'get another colour too.',
      'Wore it to work and got so many compliments.',
      'Perfect for weekend trips, it packs without wrinkling.',
      'Will definitely order from this shop again.',
    ];
    return notes[_random.nextInt(notes.length)];
  }

  /// [count] reviews, newest first. Each comment combines an impression, a
  /// detail and often a buyer note using the product's [sizes] and
  /// [colors]; lower ratings get a balanced comment. About one in three
  /// carries one or two customer photos drawn from [photos].
  static List<ReviewCommentModel> generateRandomReviews(
    int count, {
    List<String> photos = const [],
    List<String> sizes = const [],
    List<String> colors = const [],
  }) {
    var daysAgo = 0;
    return List.generate(count, (index) {
      daysAgo += 1 + _random.nextInt(12);
      // Mostly 4–5 stars, the occasional 3.
      final rating = double.parse(
        (3 + _random.nextDouble() * 2).toStringAsFixed(1),
      );
      final withPhotos = photos.isNotEmpty && _random.nextInt(3) == 0;
      final comment = rating < 3.8
          ? '${_critical[_random.nextInt(_critical.length)]} '
                '${_details[_random.nextInt(_details.length)]}'
          : [
              _openers[_random.nextInt(_openers.length)],
              _details[_random.nextInt(_details.length)],
              if (_random.nextInt(3) > 0) _context(sizes, colors),
            ].join(' ');

      return ReviewCommentModel(
        id: (index + 1).toString(),
        userName: _names[_random.nextInt(_names.length)],
        comment: comment,
        rating: rating,
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

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

  /// Details for device accessories instead of garments.
  static const _deviceDetails = [
    'It feels soft and grippy, no more slipping off the sofa.',
    'Buttons are clicky and the camera cut-out lines up exactly.',
    'Survived a few drops already without a scratch.',
    'Slim enough that wireless charging still works.',
    'The colour is lovely and does not pick up lint.',
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

  /// A buyer note about the [size] and [color] they bought, when known.
  /// A device model reads as such instead of a fit.
  static String _context(String size, String color, {required bool isModel}) {
    final notes = <String>[
      if (size.isNotEmpty && isModel)
        'Fits my $size perfectly, buttons and camera cut-out line up.',
      if (size.isNotEmpty && !isModel && size != 'One size')
        'I am ${_heights[_random.nextInt(_heights.length)]} cm and took '
            '$size, fits perfectly.',
      if (color.isNotEmpty)
        'Ordered it in $color and might get another colour too.',
      if (!isModel) ...[
        'Wore it to work and got so many compliments.',
        'Perfect for weekend trips, it packs without wrinkling.',
      ],
      'Will definitely order from this shop again.',
    ];
    return notes[_random.nextInt(notes.length)];
  }

  /// [count] reviews, newest first. Each records the variation bought (one
  /// of [colors] × [sizes]) and combines an impression, a detail and often
  /// a buyer note about that variation; lower ratings get a balanced
  /// comment. About one in three carries one or two customer photos drawn
  /// from [photos]. [sizesAreModels] when [sizes] lists phone models.
  static List<ReviewCommentModel> generateRandomReviews(
    int count, {
    List<String> photos = const [],
    List<String> sizes = const [],
    List<String> colors = const [],
    bool sizesAreModels = false,
  }) {
    final details = sizesAreModels ? _deviceDetails : _details;
    var daysAgo = 0;
    return List.generate(count, (index) {
      daysAgo += 1 + _random.nextInt(12);
      // Mostly 4–5 stars, the occasional 3.
      final rating = double.parse(
        (3 + _random.nextDouble() * 2).toStringAsFixed(1),
      );
      final withPhotos = photos.isNotEmpty && _random.nextInt(3) == 0;
      final color = colors.isEmpty
          ? ''
          : colors[_random.nextInt(colors.length)];
      final size = sizes.isEmpty ? '' : sizes[_random.nextInt(sizes.length)];
      final comment = rating < 3.8
          ? '${_critical[_random.nextInt(_critical.length)]} '
                '${details[_random.nextInt(details.length)]}'
          : [
              _openers[_random.nextInt(_openers.length)],
              details[_random.nextInt(details.length)],
              if (_random.nextInt(3) > 0)
                _context(size, color, isModel: sizesAreModels),
            ].join(' ');

      return ReviewCommentModel(
        id: (index + 1).toString(),
        userName: _names[_random.nextInt(_names.length)],
        comment: comment,
        rating: rating,
        colorName: color,
        size: size,
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

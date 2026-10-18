import 'dart:math';

class ProductDescriptionMock {
  // Fixed seed: the same text on every launch.
  static final _random = Random(11);

  static const _openers = [
    'A wardrobe staple you will reach for again and again.',
    'Designed for everyday wear and made to last.',
    'Clean lines and an easy shape that works with everything.',
    'An update on a classic, cut for comfort.',
  ];

  static const _closers = [
    'Machine wash cold, hang to dry.',
    'Pair it with denim for the weekend or tailoring for the office.',
    'Our model is 178 cm and wears a size M.',
    'Responsibly made in partner factories we audit every year.',
  ];

  static String generate({
    required String name,
    required String material,
    required String fit,
  }) {
    final opener = _openers[_random.nextInt(_openers.length)];
    final closer = _closers[_random.nextInt(_closers.length)];
    return '$opener The $name is made from ${material.toLowerCase()} '
        'with a ${fit.toLowerCase()} fit. $closer';
  }
}

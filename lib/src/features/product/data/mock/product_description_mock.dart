import 'dart:math';

/// Copy for one category: how the piece is introduced, what stands out,
/// how to wear it, how to care for it and how it fits.
class _CategoryCopy {
  final List<String> openers;
  final List<String> highlights;
  final List<String> styling;
  final List<String> care;
  final List<String> fitNotes;

  const _CategoryCopy({
    required this.openers,
    required this.highlights,
    required this.styling,
    required this.care,
    required this.fitNotes,
  });
}

class ProductDescriptionMock {
  // Fixed seed: the same text on every launch.
  static final _random = Random(11);

  static const _modelNotes = [
    'Our model is 175 cm and wears a size S.',
    'Our model is 168 cm and wears a size XS.',
    'Our model is 183 cm and wears a size M.',
    'Our model is 188 cm and wears a size L.',
  ];

  static const _sizeAdvice = [
    'True to size. Between sizes? Take the larger one for a softer drape.',
    'True to size, with room to layer underneath.',
    'Runs slightly small; we suggest one size up.',
    'True to size for a close, tailored look.',
  ];

  static const _clothingCare = [
    'Machine wash cold on a gentle cycle, inside out. Do not tumble dry. '
        'Cool iron if needed.',
    'Hand wash or gentle machine wash at 30 °C. Dry flat in the shade to '
        'keep its shape.',
    'Machine wash at 30 °C with similar colours. Line dry and steam to '
        'refresh.',
  ];

  /// Copy for device accessories sold per phone model.
  static const _deviceCopy = _CategoryCopy(
    openers: [
      'Everyday protection that still feels like the bare phone.',
      'Slim, grippy and made to be picked up a hundred times a day.',
    ],
    highlights: [
      'Precise cut-outs for every button, port and camera',
      'Raised lip guards the screen and lenses when face down',
      'Soft microfiber lining against scratches',
      'Works with wireless and MagSafe-style charging',
      'Drop-tested from 1.5 m',
    ],
    styling: [
      'Pick the exact model below so every cut-out lines up.',
      'Collect a few colours and swap to match your outfit.',
    ],
    care: [
      'Wipe with a damp cloth and mild soap. Let it dry before refitting.',
    ],
    fitNotes: ['Made for one phone model; choose yours under Model.'],
  );

  static const _copy = <String, _CategoryCopy>{
    'women-tops': _CategoryCopy(
      openers: [
        'The top you will reach for before you have finished your coffee.',
        'Light, easy and quietly polished, from desk to dinner.',
        'A modern essential with the softness of a favourite tee.',
      ],
      highlights: [
        'Breathable fabric that stays cool through long days',
        'Clean neckline that sits flat under blazers',
        'Slightly longer back hem for easy tucking',
        'Tonal buttons and finished inside seams',
        'Holds its colour wash after wash',
      ],
      styling: [
        'Tuck it into wide-leg trousers with loafers, or wear it loose over '
            'denim for the weekend.',
        'Layer it under a camel coat now and on its own when the sun comes '
            'out.',
      ],
      care: _clothingCare,
      fitNotes: _modelNotes,
    ),
    'women-dresses': _CategoryCopy(
      openers: [
        'One piece, the whole outfit decided.',
        'A dress that moves with you, from a garden lunch to a late dinner.',
        'Effortless shape, considered details, zero ironing stress.',
      ],
      highlights: [
        'Fully lined bodice, so no slip needed',
        'Hidden side pockets deep enough for a phone',
        'Concealed back zip with a hook-and-eye finish',
        'Midi length that falls just below the knee',
        'Adjustable waist tie for a defined silhouette',
      ],
      styling: [
        'Add flat sandals and a straw tote for daytime, then swap to block '
            'heels and gold hoops after six.',
        'Throw a denim jacket over the shoulders when the evening cools '
            'down.',
      ],
      care: _clothingCare,
      fitNotes: _modelNotes,
    ),
    'women-skirts': _CategoryCopy(
      openers: [
        'The skirt that makes a plain tee look intentional.',
        'Swishy, flattering and made for walking the whole city.',
      ],
      highlights: [
        'Comfortable elasticated back waistband',
        'Bias cut that skims rather than clings',
        'Soft lining for an opaque, smooth finish',
        'Invisible side zip',
      ],
      styling: [
        'Pair with a tucked knit and ankle boots, or a cami and sneakers '
            'for warm days.',
        'Wear it with a crisp white shirt and a slim belt for the office.',
      ],
      care: _clothingCare,
      fitNotes: _sizeAdvice,
    ),
    'men-tshirts': _CategoryCopy(
      openers: [
        'The tee every wardrobe is built on.',
        'Heavyweight feel, featherlight comfort.',
        'A clean, everyday tee that keeps its shape past the hundredth wash.',
      ],
      highlights: [
        'Dense jersey that is never see-through',
        'Ribbed crew neck that will not stretch out',
        'Pre-shrunk, so the fit you buy is the fit you keep',
        'Side-seamed body for a straight hang',
        'Taped shoulders for structure',
      ],
      styling: [
        'Wear it under an overshirt, or alone with chinos and white '
            'sneakers.',
        'Layer it beneath a bomber for an easy weekend uniform.',
      ],
      care: _clothingCare,
      fitNotes: _modelNotes,
    ),
    'men-shirts': _CategoryCopy(
      openers: [
        'Sharp enough for Monday, relaxed enough for Saturday.',
        'A shirt with tailoring details and an easygoing attitude.',
      ],
      highlights: [
        'Soft, structured collar that holds without stiffness',
        'Mother-of-pearl effect buttons',
        'Curved hem that works tucked or untucked',
        'Back box pleat for freedom of movement',
        'Single chest pocket',
      ],
      styling: [
        'Button it up with tailored trousers, or wear it open over a tee '
            'with jeans.',
        'Roll the sleeves twice and add a leather belt for smart casual.',
      ],
      care: _clothingCare,
      fitNotes: _modelNotes,
    ),
    'jeans': _CategoryCopy(
      openers: [
        'Denim that feels broken in from the very first wear.',
        'The pair you will wear four days a week and never get bored of.',
        'Classic five-pocket denim, refined for everyday comfort.',
      ],
      highlights: [
        'Comfort stretch that recovers after every wear',
        'Mid-rise waist that sits right on the hip',
        'Reinforced belt loops and rivets',
        'Zip fly with a branded shank button',
        'Washed for a soft, lived-in hand feel',
      ],
      styling: [
        'Cuff them once and pair with loafers, or keep them full length '
            'over sneakers.',
        'Works with everything from a cashmere knit to a plain white tee.',
      ],
      care: [
        'Wash rarely, inside out, at 30 °C to keep the colour deep. Line '
            'dry. Expect a little colour transfer on the first wears.',
      ],
      fitNotes: [
        'True to waist size. Inside leg 78 cm on size 30.',
        'Fits snug at first and relaxes slightly with wear; take your usual '
            'size.',
      ],
    ),
    'trousers': _CategoryCopy(
      openers: [
        'Tailored comfort for long days and longer walks.',
        'Trousers that look pressed even after the commute.',
      ],
      highlights: [
        'Wrinkle-resistant fabric with a soft drape',
        'Partially elasticated waistband',
        'Deep front pockets and secure back welt pocket',
        'Pressed front crease',
      ],
      styling: [
        'Wear them with a fine knit and loafers, or a hoodie and runners '
            'for the weekend.',
        'Match with the same tone on top for an easy tonal look.',
      ],
      care: _clothingCare,
      fitNotes: _sizeAdvice,
    ),
    'hoodies': _CategoryCopy(
      openers: [
        'Brushed-back softness you can feel from the first pull-on.',
        'The hoodie that becomes everyone in the house’s favourite.',
      ],
      highlights: [
        'Brushed fleece interior for warmth without weight',
        'Double-layer hood with flat drawcords',
        'Kangaroo pocket with hidden phone sleeve',
        'Ribbed cuffs and hem that keep their shape',
        'Dropped shoulder for a relaxed silhouette',
      ],
      styling: [
        'Pair with joggers on slow days or layer under a wool coat in the '
            'city.',
        'Throw it over a tee after the gym and keep moving.',
      ],
      care: _clothingCare,
      fitNotes: _sizeAdvice,
    ),
    'jackets': _CategoryCopy(
      openers: [
        'The layer that finishes every outfit.',
        'Built for changing skies and looking good while they change.',
        'A timeless outer layer that only gets better with the years.',
      ],
      highlights: [
        'Water-repellent finish for light rain',
        'Fully lined with internal phone pocket',
        'Two-way front zip with storm flap',
        'Adjustable cuffs and hem',
        'Room to layer a knit underneath',
      ],
      styling: [
        'Wear it over a hoodie for the weekend, or a shirt and knit for the '
            'office.',
        'Leave it open over a dress with ankle boots.',
      ],
      care: [
        'Spot clean where possible. Professional dry clean recommended to '
            'keep the finish.',
        'Machine wash cold on a delicate cycle, close all zips. Line dry, '
            'no ironing on trims.',
      ],
      fitNotes: _modelNotes,
    ),
    'activewear': _CategoryCopy(
      openers: [
        'Made to move, from the first rep to the cool-down walk home.',
        'Second-skin comfort for every kind of workout.',
      ],
      highlights: [
        'Four-way stretch with fast-drying, sweat-wicking fabric',
        'Squat-proof, opaque knit',
        'Flatlock seams that will not rub',
        'Hidden pocket for keys or a card',
        'Reflective details for early runs',
      ],
      styling: [
        'Pair with a matching top, or wear with an oversized hoodie on the '
            'way to the studio.',
        'Goes from the gym to coffee with friends without a change.',
      ],
      care: [
        'Machine wash cold, no fabric softener so it keeps wicking. Hang '
            'to dry.',
      ],
      fitNotes: [
        'Compressive fit. Between sizes? Size up for comfort, down for '
            'support.',
        'True to size with a supportive feel.',
      ],
    ),
    'kids': _CategoryCopy(
      openers: [
        'Tough enough for the playground, soft enough for nap time.',
        'Easy on, easy off, easy to love.',
      ],
      highlights: [
        'Gentle, breathable cotton that is kind to skin',
        'Reinforced knees and seams for active days',
        'Easy-pull waist with no fiddly buttons',
        'Colours that stay bright after many washes',
      ],
      styling: [
        'Mix and match with the rest of the range; every colour works '
            'together.',
      ],
      care: ['Machine wash at 40 °C with similar colours. Tumble dry low.'],
      fitNotes: [
        'Generous fit with room to grow. Choose by age or by height on the '
            'size chart.',
      ],
    ),
    'shoes': _CategoryCopy(
      openers: [
        'The pair you will wear until the soles say stop.',
        'All-day comfort that still looks sharp at night.',
        'Clean lines, cushioned steps, endless outfits.',
      ],
      highlights: [
        'Cushioned removable insole',
        'Grippy rubber outsole',
        'Padded collar and tongue',
        'Breathable lining that keeps feet fresh',
        'Lightweight build for long walks',
      ],
      styling: [
        'Wear them with cropped trousers and no-show socks, or with a '
            'midi dress for contrast.',
        'Easy with denim, tailoring and everything in between.',
      ],
      care: [
        'Wipe with a damp cloth. Air dry away from direct heat. Use a '
            'protector spray before the first wear.',
      ],
      fitNotes: [
        'True to size. Half sizes, go up.',
        'Snug at first, moulds to your foot within a few wears.',
      ],
    ),
    'bags': _CategoryCopy(
      openers: [
        'Everything you need, beautifully organised.',
        'A bag that works as hard as you do and looks better every year.',
      ],
      highlights: [
        'Fits a 13-inch laptop or tablet',
        'Interior zip pocket and two slip pockets',
        'Magnetic closure for quick access',
        'Adjustable, detachable strap',
        'Protective metal feet on the base',
      ],
      styling: [
        'Carry it by hand to the office, or cross-body on weekend errands.',
        'A neutral finish that goes with every outfit in your wardrobe.',
      ],
      care: [
        'Wipe clean with a soft dry cloth. Store stuffed in the dust bag '
            'provided to keep its shape.',
      ],
      fitNotes: [
        'Approx. 34 × 26 × 12 cm. Strap drop 55 cm.',
        'Approx. 24 × 16 × 7 cm. Strap drop 50–60 cm.',
      ],
    ),
    'accessories': _CategoryCopy(
      openers: [
        'The finishing touch that makes the outfit yours.',
        'Small detail, big difference.',
      ],
      highlights: [
        'Soft-touch finish that feels premium',
        'Lightweight enough to forget you are wearing it',
        'Gift-ready packaging',
        'Designed to pair with the whole range',
      ],
      styling: [
        'Add it to a simple tee and jeans to make the look feel finished.',
        'Layer it with your other pieces for a personal mix.',
      ],
      care: ['Store away from moisture. Wipe gently with a soft cloth.'],
      fitNotes: ['One size fits most.'],
    ),
  };

  static T _pick<T>(List<T> items) => items[_random.nextInt(items.length)];

  /// Three highlights in their catalog order, chosen without repeats.
  static List<String> _pickHighlights(List<String> all) {
    final picked = <int>{};
    while (picked.length < min(3, all.length)) {
      picked.add(_random.nextInt(all.length));
    }
    return [for (final i in picked.toList()..sort()) all[i]];
  }

  /// A full product description: story, highlights, care and fit, as
  /// paragraphs separated by blank lines.
  static String generate({
    required String categoryId,
    bool forDevice = false,
    required String material,
    required String fit,
  }) {
    final copy = forDevice
        ? _deviceCopy
        : _copy[categoryId] ?? _copy['accessories']!;
    final highlights = _pickHighlights(copy.highlights);

    return [
      // "Cut in …" reads right for singular and plural names alike.
      '${_pick(copy.openers)} Cut in ${material.toLowerCase()} with a '
          '${fit.toLowerCase()} fit. ${_pick(copy.styling)}',
      'Highlights\n${highlights.map((h) => '•  $h').join('\n')}',
      'Care\n${_pick(copy.care)}',
      'Size & fit\n${_pick(copy.fitNotes)}',
    ].join('\n\n');
  }
}

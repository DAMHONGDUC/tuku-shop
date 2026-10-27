import 'package:tuku_shop/src/features/chat/data/models/chat_models.dart';

/// The demo inbox: the support desk and a few shops with some history, and
/// the answers each side gives by keyword (English and Vietnamese).
class ChatMock {
  static const supportPeerId = 'tuku-care';

  static const supportGreeting =
      'Hi! I am Mai from Tuku Care. Ask me about an order, delivery, '
      'returns or vouchers, and I will help right away.';

  static const shopGreeting =
      'Hi, thanks for visiting our shop! Ask us about stock, sizing or '
      'delivery and we will answer in a few minutes.';

  /// First-launch threads: (peerId, peerType, minutes ago, unread,
  /// messages as (sender, text)).
  static const _seed = <(String, String, int, int, List<(String, String)>)>[
    (supportPeerId, 'support', 60 * 26, 0, [('peer', supportGreeting)]),
    (
      'aurora-official',
      'seller',
      12,
      1,
      [
        ('customer', 'Hi! Does the Floral Midi Dress run true to size?'),
        (
          'peer',
          'Hi! It is true to size. If you are between sizes, take the '
              'larger one for a softer drape. Our model is 168 cm in XS.',
        ),
      ],
    ),
    (
      'northline-official',
      'seller',
      60 * 3,
      0,
      [
        ('customer', 'When will my Slim Fit Jeans ship?'),
        (
          'peer',
          'Your order ships today and arrives in 2–4 days. You can track '
              'it in My orders.',
        ),
        ('customer', 'Great, thank you!'),
      ],
    ),
    (
      'stride-sports',
      'seller',
      60 * 30,
      1,
      [
        (
          'peer',
          'Thanks for following Stride Sports! New running gear lands '
              'this week. Use TUKU10 for 10% off your first order.',
        ),
      ],
    ),
  ];

  /// The seed threads and their messages, timed back from [now].
  static (List<ConversationModel>, Map<String, List<ChatMessageModel>>) seed(
    DateTime now,
  ) {
    final conversations = <ConversationModel>[];
    final messages = <String, List<ChatMessageModel>>{};
    for (final (peerId, type, minutesAgo, unread, lines) in _seed) {
      final id = 'c-$peerId';
      final end = now.subtract(Duration(minutes: minutesAgo));
      messages[id] = [
        for (var i = 0; i < lines.length; i++)
          ChatMessageModel(
            id: '$id-${i + 1}',
            conversationId: id,
            sender: lines[i].$1,
            text: lines[i].$2,
            // Earlier lines a few minutes before the last one.
            sentAt: end
                .subtract(Duration(minutes: (lines.length - 1 - i) * 3))
                .toIso8601String(),
          ),
      ];
      conversations.add(
        ConversationModel(
          id: id,
          peerId: peerId,
          peerType: type,
          lastMessage: lines.last.$2,
          updatedAt: end.toIso8601String(),
          unreadCount: unread,
        ),
      );
    }
    return (conversations, messages);
  }

  static const _supportAnswers = <(List<String>, String)>[
    (
      ['order', 'track', 'where', 'đơn', 'theo dõi', 'đâu'],
      'You can follow every order in Profile → My orders. Send me the order '
          'number (like #TK100012) and I will check its status for you.',
    ),
    (
      ['return', 'exchange', 'refund', 'đổi', 'trả', 'hoàn'],
      'Returns are free within 30 days if the item is unworn with its tags. '
          'Start one from the order in My orders; refunds land 3–5 days '
          'after we receive it.',
    ),
    (
      ['ship', 'deliver', 'giao', 'vận chuyển', 'phí'],
      'Standard delivery is \$4.99 and free over \$100; Express is \$12.99 '
          'and arrives the next working day in most cities.',
    ),
    (
      ['voucher', 'code', 'discount', 'promo', 'mã', 'giảm', 'khuyến'],
      'Try TUKU10 for 10% off, or FREESHIP for free standard delivery. '
          'Enter the code at checkout.',
    ),
    (
      ['pay', 'card', 'cod', 'thanh toán', 'thẻ'],
      'We accept cash on delivery, cards and e-wallets; you are charged '
          'only once the order is confirmed.',
    ),
    (
      ['thank', 'cảm ơn', 'ok'],
      'You are welcome! Anything else I can help with?',
    ),
  ];

  static const _shopAnswers = <(List<String>, String)>[
    (
      ['stock', 'available', 'còn', 'hết'],
      'Yes, it is in stock! Sizes that show on the product page can be '
          'ordered right away; greyed-out sizes are sold out for now.',
    ),
    (
      ['size', 'fit', 'cỡ', 'vừa'],
      'Most of our pieces are true to size. Tell us your height and usual '
          'size and we will recommend one.',
    ),
    (
      ['ship', 'deliver', 'when', 'giao', 'khi nào', 'bao lâu'],
      'We pack orders the same day and hand them to the courier by 6 pm; '
          'delivery takes 2–4 days.',
    ),
    (
      ['discount', 'voucher', 'sale', 'giảm', 'mã', 'khuyến'],
      'Follow our shop for new drops, and use TUKU10 at checkout for 10% '
          'off your order.',
    ),
    (
      ['return', 'exchange', 'đổi', 'trả'],
      'You can return or exchange within 30 days, free of charge, as long '
          'as the tags are still on.',
    ),
    (
      ['thank', 'cảm ơn', 'ok'],
      'Thank you for shopping with us! Message us anytime.',
    ),
  ];

  static const _supportFallback =
      'Thanks for your message! A teammate will look into it. Meanwhile I '
      'can help with orders, delivery, returns and vouchers.';

  static const _shopFallback =
      'Thanks for your message! Our team will get back to you shortly.';

  /// The answer to [text] from the support desk or a shop.
  static String answerTo(String text, {required bool fromSupport}) {
    final lower = text.toLowerCase();
    final answers = fromSupport ? _supportAnswers : _shopAnswers;
    for (final (keywords, answer) in answers) {
      if (keywords.any(lower.contains)) return answer;
    }
    return fromSupport ? _supportFallback : _shopFallback;
  }
}

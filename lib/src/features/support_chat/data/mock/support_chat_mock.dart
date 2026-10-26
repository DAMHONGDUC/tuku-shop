/// The demo support desk: one agent, a greeting, and answers picked by
/// keywords (English and Vietnamese) in what the customer wrote.
class SupportChatMock {
  static const agentName = 'Mai · Tuku Care';

  static const greeting =
      'Hi! I am Mai from Tuku Care. Ask me about an order, delivery, '
      'returns, sizing or vouchers, and I will help right away.';

  /// Keyword groups to an answer; the first group that matches wins.
  static const _answers = <(List<String>, String)>[
    (
      ['order', 'track', 'where', 'đơn', 'theo dõi', 'đâu'],
      'You can follow every order in Profile → My orders. Orders ship '
          'within 24 hours and arrive in 2–4 days. Send me the order number '
          '(like #TK100012) and I will check its status for you.',
    ),
    (
      ['ship', 'deliver', 'giao', 'vận chuyển', 'phí'],
      'Standard delivery is \$4.99 and free over \$100; Express is \$12.99 '
          'and arrives the next working day in most cities.',
    ),
    (
      ['return', 'exchange', 'refund', 'đổi', 'trả', 'hoàn'],
      'Returns are free within 30 days as long as the item is unworn with '
          'its tags. Start one from the order in My orders and a courier '
          'picks it up; refunds land 3–5 days after we receive it.',
    ),
    (
      ['size', 'fit', 'cỡ', 'size', 'vừa'],
      'Each product page has a Size & fit note. If you are between sizes '
          'take the larger one for a relaxed fit, or tell me your height and '
          'the item and I will suggest a size.',
    ),
    (
      ['voucher', 'code', 'discount', 'promo', 'mã', 'giảm', 'khuyến'],
      'Try TUKU10 for 10% off your order, or FREESHIP for free standard '
          'delivery. Enter the code at checkout.',
    ),
    (
      ['pay', 'card', 'cod', 'thanh toán', 'thẻ'],
      'We accept cash on delivery, cards and e-wallets. You choose the '
          'method at checkout and are only charged once the order is '
          'confirmed.',
    ),
    (
      ['thank', 'thanks', 'cảm ơn', 'ok'],
      'You are welcome! Is there anything else I can help with?',
    ),
  ];

  static const _fallback =
      'Thanks for your message! A teammate will look into it. Meanwhile I '
      'can help with orders, delivery, returns, sizing and vouchers.';

  /// The agent's answer to [text].
  static String answerTo(String text) {
    final lower = text.toLowerCase();
    for (final (keywords, answer) in _answers) {
      if (keywords.any(lower.contains)) return answer;
    }
    return _fallback;
  }
}

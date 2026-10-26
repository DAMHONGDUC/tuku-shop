import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';

/// One message: the customer's on the right in brand purple, the other
/// side's on the left on a card, each with its time.
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessage message;

  static String time(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final mine = message.isMine;
    const corner = Radius.circular(SdSpacingV5.s16);
    const tail = Radius.circular(SdSpacingV5.s4);

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Column(
          crossAxisAlignment: mine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SdSpacingV5.s12,
                vertical: SdSpacingV5.s10,
              ),
              decoration: BoxDecoration(
                color: mine ? colors.primary : colors.cardDefault,
                borderRadius: BorderRadius.only(
                  topLeft: corner,
                  topRight: corner,
                  bottomLeft: mine ? corner : tail,
                  bottomRight: mine ? tail : corner,
                ),
              ),
              child: Text(
                message.text,
                style: SdTextStyleV5.body14()
                    .wColor(mine ? colors.onPrimary : colors.textDefault)
                    .copyWith(height: 1.4),
              ),
            ),
            SdVerticalSpacingV5(value: SdSpacingV5.s2),
            Text(
              time(message.sentAt),
              style: SdTextStyleV5.body10().wColor(colors.textSubTitle),
            ),
          ],
        ),
      ),
    );
  }
}

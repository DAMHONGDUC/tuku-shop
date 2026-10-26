import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Quick questions and the message field with Send, pinned under the
/// thread. Sits at safe area + 4, and right above the keyboard.
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    super.key,
    required this.quickQuestions,
    required this.onSend,
    required this.enabled,
    required this.isSending,
  });

  final List<String> quickQuestions;

  /// Returns whether the message went out; the field clears only then.
  final Future<bool> Function(String text) onSend;
  final bool enabled;
  final bool isSending;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send(String text) async {
    if (!widget.enabled) return;
    final sent = await widget.onSend(text);
    if (sent && mounted && _text.text.trim() == text.trim()) _text.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final loc = context.loc;
    // The keyboard takes the safe area; otherwise sit on it + 4.
    final keyboardUp = MediaQuery.viewInsetsOf(context).bottom > 0;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceDefault,
        border: Border(top: BorderSide(color: colors.borderDefault)),
      ),
      padding: EdgeInsets.only(
        top: SdSpacingV5.s8,
        bottom: keyboardUp
            ? SdSpacingV5.s8
            : BottomActionBar.bottomGap(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: SdSpacingV5.s36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
              itemCount: widget.quickQuestions.length,
              separatorBuilder: (_, _) =>
                  SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              itemBuilder: (context, i) => AppChip(
                label: widget.quickQuestions[i],
                enabled: widget.enabled && !widget.isSending,
                onTap: () => _send(widget.quickQuestions[i]),
              ),
            ),
          ),
          SdVerticalSpacingV5(value: SdSpacingV5.s8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _text,
                    enabled: widget.enabled,
                    minLines: 1,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    style: SdTextStyleV5.body14().wColor(colors.textDefault),
                    decoration: InputDecoration(
                      hintText: loc.support_input_hint,
                      hintStyle: SdTextStyleV5.body14().wColor(
                        colors.textSubTitle,
                      ),
                      filled: true,
                      fillColor: colors.cardDefault,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SdSpacingV5.s16,
                        vertical: SdSpacingV5.s12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(SdSpacingV5.s24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _text,
                  builder: (context, value, _) {
                    final ready =
                        widget.enabled &&
                        !widget.isSending &&
                        value.text.trim().isNotEmpty;
                    return Semantics(
                      button: true,
                      enabled: ready,
                      label: loc.support_send,
                      excludeSemantics: true,
                      child: Material(
                        color: ready ? colors.primary : colors.cardDefault,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: ready ? () => _send(value.text) : null,
                          child: SizedBox.square(
                            dimension: UIConstants.minTapTarget,
                            child: widget.isSending
                                ? Padding(
                                    padding: EdgeInsets.all(SdSpacingV5.s12),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colors.primary,
                                    ),
                                  )
                                : SdIconV5(
                                    iconData: Icons.send_rounded,
                                    iconSize: SdSpacingV5.s20,
                                    color: ready
                                        ? colors.onPrimary
                                        : colors.iconSecondary,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

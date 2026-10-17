import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';

/// One question that opens to show its answer.
class FaqTile extends StatefulWidget {
  const FaqTile({required this.question, required this.answer, super.key});

  final String question;
  final String answer;

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final Duration duration = SdMotionV5.of(context, SdMotionV5.normal);

    return Semantics(
      expanded: _open,
      child: SdCardV5(
        layer: SdCardLayerV5.outlined,
        onTap: () => setState(() => _open = !_open),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.question,
                    style: context.textTheme5.titleSmall,
                  ),
                ),
                SizedBox(width: SdSpacingConstant.w8),
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: duration,
                  curve: SdMotionV5.standard,
                  child: SdIconV5(
                    Symbols.expand_more_rounded,
                    color: context.sdTheme5.textSecondary,
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: duration,
              curve: SdMotionV5.standard,
              alignment: Alignment.topCenter,
              child: _open
                  ? Padding(
                      padding: EdgeInsets.only(top: SdSpacingConstant.h8),
                      child: Text(
                        widget.answer,
                        style: context.textTheme5.bodyMedium!.muted5(context),
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

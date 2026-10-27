import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A row that slides left to reveal one destructive action behind it. A
/// drag past half the action, or a quick fling, leaves it open; the action
/// runs only when tapped. Tapping the row, sliding it back, or opening
/// another row closes it.
class SwipeAction extends StatefulWidget {
  const SwipeAction({
    super.key,
    required this.label,
    required this.onAction,
    required this.child,
    this.icon = Icons.delete_outline_rounded,
    this.surfaceColor,
  });

  final String label;
  final IconData icon;
  final VoidCallback onAction;
  final Widget child;

  /// Paints the row so it hides the action while closed; defaults to the
  /// card surface.
  final Color? surfaceColor;

  /// The revealed action's width.
  static const actionWidth = 88.0;

  /// A fling faster than this (logical px/s) opens or closes outright.
  static const _flingVelocity = 300.0;

  @override
  State<SwipeAction> createState() => _SwipeActionState();
}

class _SwipeActionState extends State<SwipeAction>
    with SingleTickerProviderStateMixin {
  /// The one row left open; opening another closes it.
  static _SwipeActionState? _openRow;

  /// 0 closed, 1 fully open.
  late final AnimationController _reveal = AnimationController(
    vsync: this,
    duration: UIConstants.navNormal,
  );

  bool get _isOpen => _reveal.value > 0;

  void _settle({required bool open}) {
    if (open) {
      if (_openRow != this) _openRow?._settle(open: false);
      _openRow = this;
      if (_reveal.value < 1) HapticFeedback.selectionClick();
    } else if (_openRow == this) {
      _openRow = null;
    }
    _reveal.animateTo(open ? 1 : 0, curve: Curves.easeOutCubic);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _reveal.value -= details.primaryDelta! / SwipeAction.actionWidth;
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() > SwipeAction._flingVelocity) {
      _settle(open: velocity < 0);
    } else {
      _settle(open: _reveal.value > 0.5);
    }
  }

  void _runAction() {
    _settle(open: false);
    widget.onAction();
  }

  @override
  void dispose() {
    if (_openRow == this) _openRow = null;
    _reveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Semantics(
      customSemanticsActions: {
        CustomSemanticsAction(label: widget.label): widget.onAction,
      },
      child: ClipRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: SwipeAction.actionWidth,
                  child: Material(
                    color: colors.sale,
                    child: InkWell(
                      onTap: _runAction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SdIconV5(
                            iconData: widget.icon,
                            iconSize: SdSpacingV5.s22,
                            color: AppColors.white,
                          ),
                          SdVerticalSpacingV5(value: SdSpacingV5.s4),
                          Text(
                            widget.label,
                            style: SdTextStyleV5.body12()
                                .wColor(AppColors.white)
                                .wSemiBold(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // The gestures move with the row, so they never cover the action.
            AnimatedBuilder(
              animation: _reveal,
              builder: (context, child) => Transform.translate(
                offset: Offset(-SwipeAction.actionWidth * _reveal.value, 0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  onTap: _isOpen ? () => _settle(open: false) : null,
                  // While open, a tap on the row only closes it.
                  child: AbsorbPointer(absorbing: _isOpen, child: child),
                ),
              ),
              // Full width, so the closed row always hides the action.
              child: SizedBox(
                width: double.infinity,
                child: ColoredBox(
                  color: widget.surfaceColor ?? colors.cardDefault,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Calls [onLoadMore] when the nearest vertical scroll view comes within
/// [UIConstants.loadMoreThreshold] of its end.
class LoadMoreListener extends StatelessWidget {
  const LoadMoreListener({
    super.key,
    required this.onLoadMore,
    required this.child,
  });

  final VoidCallback onLoadMore;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (notification.depth == 0 &&
            metrics.axis == Axis.vertical &&
            metrics.extentAfter < UIConstants.loadMoreThreshold) {
          onLoadMore();
        }
        return false;
      },
      child: child,
    );
  }
}

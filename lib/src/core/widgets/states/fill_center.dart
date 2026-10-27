import 'package:flutter/material.dart';

/// Fills the rest of a [CustomScrollView] and centres [child] in it, so an
/// empty state below a header sits mid-screen.
class SliverFillCenter extends StatelessWidget {
  const SliverFillCenter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: child),
    );
  }
}

/// A scroll view holding only [child], centred on screen; it stays
/// scrollable so pull-to-refresh still works around an empty state.
class FillCenterScrollView extends StatelessWidget {
  const FillCenterScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [SliverFillCenter(child: child)],
    );
  }
}

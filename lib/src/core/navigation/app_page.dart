import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

/// Route transitions the platform default does not cover.
abstract final class AppPage {
  /// A cross-fade with a slight zoom — for moments that replace the whole
  /// app (splash → onboarding → sign in → shop) rather than drill into it.
  static Page<void> fade(GoRouterState state, Widget child) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionDuration: SdMotionV5.page,
        reverseTransitionDuration: SdMotionV5.normal,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> _,
              Widget child,
            ) {
              final Animation<double> curved = CurvedAnimation(
                parent: animation,
                curve: SdMotionV5.standard,
              );

              return FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1.03, end: 1).animate(curved),
                  child: child,
                ),
              );
            },
      );

  /// Rises from the bottom — for a flow that is finished rather than left:
  /// the order confirmation.
  static Page<void> rise(GoRouterState state, Widget child) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionDuration: SdMotionV5.page,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> _,
              Widget child,
            ) {
              final Animation<double> curved = CurvedAnimation(
                parent: animation,
                curve: SdMotionV5.standard,
              );

              return FadeTransition(
                opacity: curved,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                ),
              );
            },
      );
}

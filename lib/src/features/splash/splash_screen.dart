import 'dart:math';

import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/splash/components/splash_backdrop.dart';
import 'package:tuku_shop/src/features/splash/components/splash_logo.dart';
import 'package:tuku_shop/src/features/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

/// The one-off entrance: bag, handle, letter, name, tagline, loader. It
/// ends before [SplashController]'s 1 s minimum, so it always plays out.
const _kIntroDuration = Duration(milliseconds: 800);

/// One cycle of the background glows and loading dots.
const _kLoopDuration = Duration(milliseconds: 2400);

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashController>()..checkLoginStatus(),
      child: _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView>
    with TickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: _kIntroDuration,
  );
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: _kLoopDuration,
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    // Reduced motion: the finished frame, standing still.
    if (MediaQuery.disableAnimationsOf(context)) {
      _intro.value = 1;
    } else {
      _intro.forward();
      _loop.repeat();
    }
  }

  @override
  void dispose() {
    _intro.dispose();
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return BlocListener<SplashController, SplashState>(
      listener: (context, state) {
        if (state is LoggedInLState) {
          GoRouter.of(context).go(HomeRoutes.home.fullPath);
        } else if (state is NotLogInLState) {
          GoRouter.of(context).go(LoginRoutes.login.fullPath);
        }
      },
      child: SdAdaptiveStatusBarV5(
        // The brand purple in both themes, as the native launch screen.
        backgroundColor: AppColors.brand,
        child: Scaffold(
          backgroundColor: AppColors.brand,
          body: SplashBackdrop(
            loop: _loop,
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 5),
                  SplashLogo(intro: _intro),
                  _Wordmark(text: loc.app_name, intro: _intro),
                  SdVerticalSpacingV5(value: SdSpacingV5.s8),
                  _Reveal(
                    intro: _intro,
                    interval: const Interval(0.55, 0.9),
                    child: Text(
                      loc.splash_description,
                      textAlign: TextAlign.center,
                      style: SdTextStyleV5.body16().wColor(
                        AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  const Spacer(flex: 4),
                  _Reveal(
                    intro: _intro,
                    interval: const Interval(0.7, 1),
                    child: _LoadingDots(loop: _loop),
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The app name, letter by letter rising into place.
class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.text, required this.intro});

  final String text;
  final Animation<double> intro;

  static const _start = 0.35;
  static const _end = 0.8;

  /// Each letter's share of the window; the rest is the stagger.
  static const _letterSpan = 0.5;

  @override
  Widget build(BuildContext context) {
    final style = SdTextStyleV5.heading40()
        .wColor(AppColors.white)
        .wBold()
        .wDisplay();
    final letters = text.characters.toList();
    final step = letters.length > 1
        ? (1 - _letterSpan) / (letters.length - 1)
        : 0.0;

    return Semantics(
      header: true,
      label: text,
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: intro,
        builder: (context, _) {
          final window = const Interval(_start, _end).transform(intro.value);
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < letters.length; i++)
                Builder(
                  builder: (context) {
                    final p = Curves.easeOutBack.transform(
                      ((window - i * step) / _letterSpan).clamp(0.0, 1.0),
                    );
                    return Opacity(
                      opacity: p.clamp(0.0, 1.0),
                      child: Transform.translate(
                        offset: Offset(0, SdSpacingV5.s24 * (1 - p)),
                        child: Text(letters[i], style: style),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Fades and lifts [child] in over [interval] of [intro].
class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.intro,
    required this.interval,
    required this.child,
  });

  final Animation<double> intro;
  final Interval interval;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: intro,
      child: child,
      builder: (context, child) {
        final p = Curves.easeOutCubic.transform(
          interval.transform(intro.value),
        );
        return Opacity(
          opacity: p,
          child: Transform.translate(
            offset: Offset(0, SdSpacingV5.s12 * (1 - p)),
            child: child,
          ),
        );
      },
    );
  }
}

/// Three dots swelling in a wave, one after another.
class _LoadingDots extends StatelessWidget {
  const _LoadingDots({required this.loop});

  final Animation<double> loop;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: loop,
        builder: (context, _) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) SdHorizontalSpacingV5(value: SdSpacingV5.s8),
              Builder(
                builder: (context) {
                  // Two waves per loop, each dot a little behind the last.
                  final wave =
                      (sin((loop.value * 2 - i * 0.15) * 2 * pi) + 1) / 2;
                  return Transform.scale(
                    scale: 0.75 + 0.35 * wave,
                    child: Container(
                      width: SdSpacingV5.s8,
                      height: SdSpacingV5.s8,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(
                          alpha: 0.35 + 0.65 * wave,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<SplashController>(
    create: (BuildContext _) => getIt<SplashController>()..start(),
    child: BlocListener<SplashController, SplashState>(
      listenWhen: (SplashState a, SplashState b) => b.destination != null,
      listener: (BuildContext context, SplashState state) =>
          context.go(state.destination!.path),
      child: const _SplashView(),
    ),
  );
}

/// Ink page, the wordmark drawn in letter by letter, the tagline rising
/// under it, and a hairline that fills while the session is read.
class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: SplashController.minimumShowTime,
  )..forward();

  static const String _word = AppConstants.wordmark;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color ink = context.sdTheme5.textPrimary;
    final Color paper = context.sdTheme5.background;

    return Scaffold(
      backgroundColor: ink,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? _) {
          final double t = _controller.value;
          final double tagline = Curves.easeOutCubic.transform(
            ((t - 0.45) / 0.3).clamp(0, 1),
          );
          final double bar = Curves.easeInOutCubic.transform(
            ((t - 0.35) / 0.65).clamp(0, 1),
          );

          return Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (int i = 0; i < _word.length; i++)
                          _Letter(
                            letter: _word[i],
                            progress: Curves.easeOutBack.transform(
                              ((t - i * 0.07) / 0.3).clamp(0, 1),
                            ),
                            color: paper,
                          ),
                        _Letter(
                          letter: '.',
                          progress: Curves.easeOutBack.transform(
                            ((t - 0.32) / 0.25).clamp(0, 1),
                          ),
                          color: context.sdTheme5.accent,
                        ),
                      ],
                    ),
                    SizedBox(height: SdSpacingConstant.h8),
                    Opacity(
                      opacity: tagline,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          (1 - tagline) * SdSpacingConstant.h12,
                        ),
                        child: Text(
                          context.loc.splash_tagline.toUpperCase(),
                          style: context.textTheme5.labelMedium!.copyWith(
                            color: paper.withValues(alpha: 0.7),
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: SdSpacingConstant.w64 * 1.5,
                right: SdSpacingConstant.w64 * 1.5,
                bottom:
                    SdContentPaddingV5.detailBottom(context) +
                    SdSpacingConstant.h40,
                child: ClipRRect(
                  borderRadius: SdRadiusV5.fullAll,
                  child: LinearProgressIndicator(
                    value: bar,
                    minHeight: SdSpacingConstant.h2,
                    color: paper,
                    backgroundColor: paper.withValues(alpha: 0.15),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Letter extends StatelessWidget {
  const _Letter({
    required this.letter,
    required this.progress,
    required this.color,
  });

  final String letter;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: progress.clamp(0, 1),
    child: Transform.translate(
      offset: Offset(0, (1 - progress) * SdSpacingConstant.h24),
      child: Text(
        letter,
        style: context.textTheme5.displayLarge!.copyWith(
          color: color,
          fontSize: SdSpacingConstant.sp36 * 1.6,
          fontStyle: FontStyle.italic,
          letterSpacing: -1,
        ),
      ),
    ),
  );
}

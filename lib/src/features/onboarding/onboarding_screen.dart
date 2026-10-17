import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/app/state/settings_controller.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

import 'components/onboarding_page.dart';

/// Three full-bleed lookbook pages. Each photo drifts against the swipe, so
/// the pages feel layered rather than flat.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pages = PageController();
  int _index = 0;

  static const int _count = 3;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await getIt<SettingsController>().completeOnboarding();

    if (mounted) context.go(AppRoutes.login.path);
  }

  void _next() {
    if (_index == _count - 1) {
      _finish();
      return;
    }

    _pages.nextPage(duration: SdMotionV5.slow, curve: SdMotionV5.emphasized);
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingPageData> pages = <OnboardingPageData>[
      OnboardingPageData(
        image: AppAssets.lookHomePerformance,
        title: context.loc.onboarding_title_1,
        body: context.loc.onboarding_body_1,
      ),
      OnboardingPageData(
        image: AppAssets.lookErin,
        title: context.loc.onboarding_title_2,
        body: context.loc.onboarding_body_2,
      ),
      OnboardingPageData(
        image: AppAssets.lookHomePants,
        title: context.loc.onboarding_title_3,
        body: context.loc.onboarding_body_3,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pages,
            itemCount: _count,
            onPageChanged: (int i) => setState(() => _index = i),
            itemBuilder: (BuildContext context, int i) => AnimatedBuilder(
              animation: _pages,
              builder: (BuildContext context, Widget? _) {
                final double page =
                    _pages.hasClients && _pages.position.haveDimensions
                    ? _pages.page ?? 0
                    : 0;

                return OnboardingPage(data: pages[i], offset: page - i);
              },
            ),
          ),
          Positioned(
            top:
                SdContentPaddingV5.statusBarInset(context) +
                SdSpacingConstant.h8,
            right: SdContentPaddingV5.horizontal,
            child: AnimatedOpacity(
              opacity: _index == _count - 1 ? 0 : 1,
              duration: SdMotionV5.normal,
              child: SdButtonV5(
                variant: SdButtonVariantV5.text,
                size: SdButtonSizeV5.small,
                label: context.loc.action_skip,
                onPressed: _finish,
              ),
            ),
          ),
          Positioned(
            left: SdContentPaddingV5.horizontal,
            right: SdContentPaddingV5.horizontal,
            bottom:
                SdContentPaddingV5.detailBottom(context) +
                SdSpacingConstant.h12,
            child: Row(
              children: <Widget>[
                SdPageIndicatorV5(
                  count: _count,
                  index: _index,
                  color: Colors.white,
                  inactiveColor: Colors.white.withValues(alpha: 0.35),
                ),
                const Spacer(),
                _NextButton(last: _index == _count - 1, onPressed: _next),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A round arrow that stretches into "Get started" on the last page.
class _NextButton extends StatelessWidget {
  const _NextButton({required this.last, required this.onPressed});

  final bool last;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SdPressableV5(
    onTap: onPressed,
    semanticLabel: last
        ? context.loc.onboarding_start
        : context.loc.action_next,
    child: AnimatedContainer(
      duration: SdMotionV5.of(context, SdMotionV5.slow),
      curve: SdMotionV5.emphasized,
      height: SdSpacingConstant.h56,
      padding: EdgeInsets.symmetric(
        horizontal: last ? SdSpacingConstant.w24 : 0,
      ),
      constraints: BoxConstraints(minWidth: SdSpacingConstant.h56),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: SdRadiusV5.fullAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSize(
            duration: SdMotionV5.of(context, SdMotionV5.slow),
            curve: SdMotionV5.emphasized,
            child: last
                ? Padding(
                    padding: EdgeInsets.only(right: SdSpacingConstant.w8),
                    child: Text(
                      context.loc.onboarding_start,
                      style: context.textTheme5.labelLarge!.semiBold5.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          SdIconV5(Symbols.arrow_forward_rounded, color: Colors.black),
        ],
      ),
    ),
  );
}

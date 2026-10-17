import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.image,
    required this.title,
    required this.body,
  });

  final String image;
  final String title;
  final String body;
}

/// One onboarding page. [offset] is how far the page is from centre
/// (−1…1); the photo moves at half that speed and the copy fades with it.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({required this.data, required this.offset, super.key});

  final OnboardingPageData data;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double visible = (1 - offset.abs()).clamp(0, 1);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRect(
          child: Transform.translate(
            offset: Offset(-offset * width * 0.5, 0),
            child: Transform.scale(
              scale: 1.15,
              child: AppImage(data.image, backdrop: Colors.black),
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0x33000000),
                Color(0x00000000),
                Color(0xE6000000),
              ],
              stops: <double>[0, 0.35, 1],
            ),
          ),
        ),
        Positioned(
          left: SdContentPaddingV5.horizontal,
          right: SdContentPaddingV5.horizontal,
          bottom:
              SdContentPaddingV5.detailBottom(context) + SdSpacingConstant.h96,
          child: Opacity(
            opacity: visible,
            child: Transform.translate(
              offset: Offset(0, (1 - visible) * SdSpacingConstant.h24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: context.textTheme5.displayMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: SdSpacingConstant.h12),
                  Text(
                    data.body,
                    style: context.textTheme5.bodyLarge!.copyWith(
                      color: Colors.white.withValues(alpha: 0.82),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

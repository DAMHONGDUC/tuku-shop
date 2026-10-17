import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// The photo band at the top of the auth screens with the wordmark over it.
/// It eases up and out as the form scrolls.
class AuthHeader extends StatelessWidget {
  const AuthHeader({required this.image, required this.height, super.key});

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AppImage(image, alignment: Alignment.topCenter, backdrop: Colors.black),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.black.withValues(alpha: 0.35),
                Colors.black.withValues(alpha: 0.05),
                context.sdTheme5.background,
              ],
              stops: const <double>[0, 0.55, 1],
            ),
          ),
        ),
        Positioned(
          top: SdContentPaddingV5.statusBarInset(context) + SdSpacingConstant.h12,
          left: SdContentPaddingV5.horizontal,
          child: SdFadeInV5(
            child: Text(
              '${AppConstants.wordmark}.',
              style: context.textTheme5.headlineLarge!.copyWith(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

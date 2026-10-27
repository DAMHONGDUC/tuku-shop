import 'package:flutter/material.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A bundled photo that fades in over a tinted placeholder, so a card is
/// laid out before its picture finishes decoding.
class CatalogImage extends StatelessWidget {
  const CatalogImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.width,
    this.height,
  });

  final String path;
  final BoxFit fit;
  final double borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final placeholder = ColoredBox(color: context.colorTheme.cardOnSurface);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            placeholder,
            Image.asset(
              path,
              fit: fit,
              // Decode near display size: the source photos are 800 px.
              cacheWidth: 600,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: UIConstants.navNormal,
                  curve: Curves.easeOut,
                  child: child,
                );
              },
              errorBuilder: (context, error, stackTrace) => Center(
                child: SdIconV5(
                  iconData: Icons.image_not_supported_outlined,
                  color: context.colorTheme.iconSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

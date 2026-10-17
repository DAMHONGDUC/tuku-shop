import 'package:flutter/widgets.dart';
import 'package:system_design/index.dart';

/// A catalogue or banner photo. Paths starting with `http` load over the
/// network, everything else from the bundle — so swapping the mock for a
/// real API changes data, not widgets.
class AppImage extends StatelessWidget {
  const AppImage(
    this.path, {
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.alignment = Alignment.center,
    this.backdrop,
    super.key,
  });

  final String path;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Alignment alignment;
  final Color? backdrop;

  static ImageProvider provider(String path) => path.startsWith('http')
      ? NetworkImage(path)
      : AssetImage(path) as ImageProvider;

  @override
  Widget build(BuildContext context) => SdImageV5(
    image: provider(path),
    fit: fit,
    borderRadius: borderRadius,
    alignment: alignment,
    backdrop: backdrop,
  );
}

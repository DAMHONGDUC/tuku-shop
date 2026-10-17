import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';

import '../l10n/l10n_ext.dart';
import 'app_image.dart';

/// Opens [images] full screen on black, pinch-to-zoom, swipe between them.
Future<void> showPhotoViewer(
  BuildContext context, {
  required List<String> images,
  int initialIndex = 0,
}) => Navigator.of(context, rootNavigator: true).push(
  PageRouteBuilder<void>(
    opaque: false,
    barrierColor: Colors.black,
    transitionDuration: SdMotionV5.normal,
    pageBuilder: (BuildContext _, Animation<double> _, Animation<double> _) =>
        PhotoViewer(images: images, initialIndex: initialIndex),
    transitionsBuilder:
        (
          BuildContext _,
          Animation<double> animation,
          Animation<double> _,
          Widget child,
        ) => FadeTransition(opacity: animation, child: child),
  ),
);

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({required this.images, this.initialIndex = 0, super.key});

  final List<String> images;
  final int initialIndex;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late final PageController _pages = PageController(
    initialPage: widget.initialIndex,
  );
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Stack(
      children: <Widget>[
        PageView.builder(
          controller: _pages,
          itemCount: widget.images.length,
          onPageChanged: (int i) => setState(() => _index = i),
          itemBuilder: (BuildContext _, int i) => InteractiveViewer(
            maxScale: 4,
            child: Center(
              child: AppImage(
                widget.images[i],
                fit: BoxFit.contain,
                backdrop: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          top:
              SdContentPaddingV5.statusBarInset(context) + SdSpacingConstant.h8,
          right: SdContentPaddingV5.horizontal,
          child: SdIconButtonV5(
            icon: Symbols.close_rounded,
            tooltip: context.loc.action_close,
            variant: SdIconButtonVariantV5.floating,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            left: 0,
            right: 0,
            bottom:
                SdContentPaddingV5.detailBottom(context) +
                SdSpacingConstant.h12,
            child: Center(
              child: SdPageIndicatorV5(
                count: widget.images.length,
                index: _index,
                color: Colors.white,
                inactiveColor: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ),
      ],
    ),
  );
}

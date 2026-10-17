import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../product_detail_controller.dart';

/// The photos of the chosen colour, swiped through; picking another colour
/// cross-fades the whole gallery. The first photo is the [Hero] the card's
/// photo flew in as. Tap opens them full screen.
class DetailGallery extends StatefulWidget {
  const DetailGallery({required this.heroTag, required this.height, super.key});

  final String heroTag;
  final double height;

  static double heightFor(BuildContext context) =>
      MediaQuery.sizeOf(context).height * 0.56;

  @override
  State<DetailGallery> createState() => _DetailGalleryState();
}

class _DetailGalleryState extends State<DetailGallery> {
  final PageController _pages = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProductDetailController, ProductDetailState>(
        listenWhen: (ProductDetailState a, ProductDetailState b) =>
            a.colorIndex != b.colorIndex,
        listener: (BuildContext _, ProductDetailState _) {
          setState(() => _index = 0);
          if (_pages.hasClients) _pages.jumpToPage(0);
        },
        buildWhen: (ProductDetailState a, ProductDetailState b) =>
            a.colorIndex != b.colorIndex || a.product != b.product,
        builder: (BuildContext context, ProductDetailState state) {
          final List<String> images = state.images;

          return SizedBox(
            height: widget.height,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: SdMotionV5.of(context, SdMotionV5.slow),
                    child: PageView.builder(
                      key: ValueKey<int>(state.colorIndex),
                      controller: _pages,
                      itemCount: images.length,
                      onPageChanged: (int i) => setState(() => _index = i),
                      itemBuilder: (BuildContext context, int i) {
                        final Widget photo = GestureDetector(
                          onTap: () => showPhotoViewer(
                            context,
                            images: images,
                            initialIndex: i,
                          ),
                          child: AppImage(
                            images[i],
                            alignment: Alignment.topCenter,
                          ),
                        );

                        return i == 0 && state.colorIndex == 0
                            ? Hero(tag: widget.heroTag, child: photo)
                            : photo;
                      },
                    ),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: SdSpacingConstant.h16,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SdSpacingConstant.w8,
                          vertical: SdSpacingConstant.h6,
                        ),
                        decoration: BoxDecoration(
                          color: context.sdTheme5.surface.withValues(
                            alpha: 0.85,
                          ),
                          borderRadius: SdRadiusV5.fullAll,
                        ),
                        child: SdPageIndicatorV5(
                          count: images.length,
                          index: _index,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';

/// Swipeable photos; picking a color jumps to that color's photo.
class ProductGallery extends StatefulWidget {
  const ProductGallery({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  final _pageController = PageController();
  int _page = 0;

  List<String> get _images => widget.product.images.isEmpty
      ? [widget.product.imageUrl]
      : widget.product.images;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onColorChanged(BuildContext context, VariantSelectionState state) {
    final color = widget.product.productColors
        .where((c) => c.colorName == state.colorName)
        .firstOrNull;
    final index = color == null ? -1 : _images.indexOf(color.imageUrl);
    if (index >= 0 && index != _page && _pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: UIConstants.navNormal,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VariantSelectionController, VariantSelectionState>(
      listenWhen: (a, b) => a.colorName != b.colorName,
      listener: _onColorChanged,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (page) => setState(() => _page = page),
            itemBuilder: (context, index) => CatalogImage(path: _images[index]),
          ),
          if (_images.length > 1)
            Positioned(
              bottom: SdSpacingV5.s24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _images.length; i++)
                    AnimatedContainer(
                      duration: UIConstants.navFast,
                      margin: EdgeInsets.symmetric(horizontal: SdSpacingV5.s2),
                      width: i == _page ? SdSpacingV5.s18 : SdSpacingV5.s6,
                      height: SdSpacingV5.s6,
                      decoration: BoxDecoration(
                        color: SdColorsV5.white.withValues(
                          alpha: i == _page ? 1 : 0.6,
                        ),
                        borderRadius: BorderRadius.circular(SdSpacingV5.s6),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

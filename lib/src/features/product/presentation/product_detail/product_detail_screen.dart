import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../widgets/product_rail.dart';
import 'components/add_to_bag_bar.dart';
import 'components/description_section.dart';
import 'components/detail_gallery.dart';
import 'components/detail_skeleton.dart';
import 'components/detail_top_bar.dart';
import 'components/perks_section.dart';
import 'components/product_info_section.dart';
import 'components/review_preview_section.dart';
import 'components/variant_section.dart';
import 'product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({required this.productId, this.args, super.key});

  final String productId;
  final ProductDetailArgs? args;

  @override
  Widget build(BuildContext context) => BlocProvider<ProductDetailController>(
    create: (BuildContext _) =>
        getIt<ProductDetailController>()..load(productId),
    child: _DetailView(
      productId: productId,
      heroTag: args?.heroTag ?? 'detail-$productId',
    ),
  );
}

class _DetailView extends StatefulWidget {
  const _DetailView({required this.productId, required this.heroTag});

  final String productId;
  final String heroTag;

  @override
  State<_DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<_DetailView> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double galleryHeight = DetailGallery.heightFor(context);

    return BlocBuilder<ProductDetailController, ProductDetailState>(
      buildWhen: (ProductDetailState a, ProductDetailState b) =>
          a.status != b.status || a.product != b.product,
      builder: (BuildContext context, ProductDetailState state) => SdScaffoldV5(
        backgroundColor: context.sdTheme5.surface,
        bottomBar: state.product == null ? null : const AddToBagBar(),
        body: Stack(
          children: <Widget>[
            FadeSwitcher(
              child: switch (state.status) {
                LoadStatus.loading => DetailSkeleton(
                  heroTag: widget.heroTag,
                  galleryHeight: galleryHeight,
                ),
                LoadStatus.failure => ErrorView(
                  onRetry: () => context.read<ProductDetailController>().load(
                    widget.productId,
                  ),
                ),
                LoadStatus.success => _Content(
                  scroll: _scroll,
                  product: state.product!,
                  heroTag: widget.heroTag,
                  galleryHeight: galleryHeight,
                ),
              },
            ),
            DetailTopBar(
              scroll: _scroll,
              fadeAfter: galleryHeight * 0.7,
              title: state.product?.name ?? '',
              productId: state.product?.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.scroll,
    required this.product,
    required this.heroTag,
    required this.galleryHeight,
  });

  final ScrollController scroll;
  final ProductEntity product;
  final String heroTag;
  final double galleryHeight;

  @override
  Widget build(BuildContext context) {
    final double gap = SdContentPaddingV5.sectionGap;

    return CustomScrollView(
      controller: scroll,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: DetailGallery(heroTag: heroTag, height: galleryHeight),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: SdContentPaddingV5.gutter.copyWith(
              top: SdSpacingConstant.h20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SdFadeInV5(child: ProductInfoSection(product: product)),
                SizedBox(height: gap * 0.8),
                const SdFadeInV5(index: 1, child: VariantSection()),
                SizedBox(height: gap * 0.8),
                const SdFadeInV5(index: 2, child: PerksSection()),
                SizedBox(height: gap),
                SdFadeInV5(
                  index: 3,
                  child: DescriptionSection(product: product),
                ),
                SizedBox(height: gap),
                const ReviewPreviewSection(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: gap)),
        BlocSelector<
          ProductDetailController,
          ProductDetailState,
          List<ProductEntity>
        >(
          selector: (ProductDetailState s) => s.related,
          builder: (BuildContext context, List<ProductEntity> related) =>
              SliverToBoxAdapter(
                child: related.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: SdContentPaddingV5.gutter,
                            child: SdSectionHeaderV5(
                              title: context.loc.detail_related,
                            ),
                          ),
                          SizedBox(height: SdSpacingConstant.h14),
                          ProductRail(
                            products: related,
                            heroPrefix: 'related-${product.id}',
                          ),
                        ],
                      ),
              ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: gap)),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

import 'banner_carousel_controller.dart';

class BannerCarouselSection extends StatefulWidget {
  const BannerCarouselSection({super.key});

  @override
  State<BannerCarouselSection> createState() => _BannerCarouselSectionState();
}

class _BannerCarouselSectionState extends State<BannerCarouselSection> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerCarouselController, BannerCarouselState>(
      listener: (context, state) {
        // TODO: implement listener if need
      },
      buildWhen: (previous, current) =>
          current is BannerCarouselLoading ||
          current is BannerCarouselSuccess ||
          current is BannerCarouselError,
      builder: (context, state) {
        if (state is BannerCarouselLoading) {
          return _BannerSkeleton();
        } else if (state is BannerCarouselError) {
          return SectionError(
            onRetry: () => context.read<BannerCarouselController>().getData(),
          );
        } else if (state is BannerCarouselSuccess) {
          return Column(
            children: [
              CarouselSlider(
                items: state.banners.map((banner) {
                  final contentColor = SdColorHelperV5.getColorFromHex(
                    banner.contentColor,
                  );
                  final darkText = contentColor.computeLuminance() < 0.5;

                  return GestureDetector(
                    onTap: banner.categoryId.isEmpty
                        ? null
                        : () => context.push(
                            ProductRoutes.productListLocation(
                              title: banner.title,
                              categoryId: banner.categoryId,
                            ),
                          ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        UIConstants.bannerBorderRadius,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CatalogImage(path: banner.imageUrl),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  (darkText
                                          ? SdColorsV5.white
                                          : SdColorsV5.black)
                                      .withValues(alpha: 0.55),
                                  SdColorsV5.transparent,
                                ],
                                stops: const [0, 0.75],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(SdSpacingV5.s16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TagChip(
                                  label: banner.tag,
                                  color: banner.tagType.color,
                                ),
                                SdVerticalSpacingV5(value: SdSpacingV5.s8),
                                Text(
                                  banner.title,
                                  style: SdTextStyleV5.heading20().wColor(
                                    contentColor,
                                  ),
                                ),
                                Text(
                                  '${banner.subtitle} · ${banner.price}',
                                  style: SdTextStyleV5.body12().wColor(
                                    contentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  height: UIConstants.bannerHeight,
                  autoPlay: true,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              SdVerticalSpacingV5(),
              _BannerIndicator(
                length: state.banners.length,
                onTap: (index) => _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                colorBuilder: (index) => index == _current
                    ? context.colorTheme.indicatorActive
                    : context.colorTheme.indicatorBg,
              ),
            ],
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

class _BannerIndicator extends StatelessWidget {
  final int length;
  final void Function(int index)? onTap;
  final Color Function(int index)? colorBuilder;

  const _BannerIndicator({required this.length, this.onTap, this.colorBuilder});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return GestureDetector(
          onTap: () => onTap?.call(index),
          child: Container(
            width: SdSpacingV5.s6,
            height: SdSpacingV5.s6,
            margin: EdgeInsets.symmetric(horizontal: SdSpacingV5.s2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorBuilder?.call(index),
            ),
          ),
        );
      }),
    );
  }
}

class _BannerSkeleton extends StatelessWidget {
  const _BannerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SkeletonBox(
          height: UIConstants.bannerHeight,
          radius: UIConstants.bannerBorderRadius,
        ),
        SdVerticalSpacingV5(),
        _BannerIndicator(
          length: 8,
          colorBuilder: (index) => context.colorTheme.indicatorBg,
        ),
      ],
    );
  }
}

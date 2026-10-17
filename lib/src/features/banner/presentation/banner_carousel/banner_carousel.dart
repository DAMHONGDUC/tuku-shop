import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/banner/domain/domain.dart';

import 'banner_carousel_controller.dart';

/// The campaign carousel at the top of home. Pages turn on their own every
/// few seconds until the user touches it; the photo drifts against the swipe.
class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<BannerCarouselController>(
    create: (BuildContext _) => getIt<BannerCarouselController>()..load(),
    child: BlocBuilder<BannerCarouselController, BannerCarouselState>(
      builder: (BuildContext context, BannerCarouselState state) => FadeSwitcher(
        child: switch (state.status) {
          LoadStatus.success => _Carousel(banners: state.banners),
          _ => const _BannerSkeleton(),
        },
      ),
    ),
  );

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).width * 0.62;
}

class _BannerSkeleton extends StatelessWidget {
  const _BannerSkeleton();

  @override
  Widget build(BuildContext context) => Padding(
    padding: SdContentPaddingV5.gutter,
    child: SdShimmerV5(
      child: SdSkeletonV5(height: BannerCarousel.height(context)),
    ),
  );
}

class _Carousel extends StatefulWidget {
  const _Carousel({required this.banners});

  final List<BannerEntity> banners;

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  final PageController _pages = PageController(viewportFraction: 0.9);
  Timer? _timer;
  int _index = 0;

  static const Duration _interval = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pages.dispose();
    super.dispose();
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer.periodic(_interval, (Timer _) {
      if (!_pages.hasClients || MediaQuery.disableAnimationsOf(context)) return;

      _pages.animateToPage(
        (_index + 1) % widget.banners.length,
        duration: SdMotionV5.page * 1.4,
        curve: SdMotionV5.emphasized,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      SizedBox(
        height: BannerCarousel.height(context),
        child: NotificationListener<ScrollStartNotification>(
          onNotification: (ScrollStartNotification n) {
            if (n.dragDetails != null) _schedule();
            return false;
          },
          child: PageView.builder(
            controller: _pages,
            itemCount: widget.banners.length,
            onPageChanged: (int i) => setState(() => _index = i),
            itemBuilder: (BuildContext context, int i) => AnimatedBuilder(
              animation: _pages,
              builder: (BuildContext context, Widget? _) {
                final double page =
                    _pages.hasClients && _pages.position.haveDimensions
                    ? _pages.page ?? 0
                    : 0;

                return _BannerPage(banner: widget.banners[i], offset: page - i);
              },
            ),
          ),
        ),
      ),
      SizedBox(height: SdSpacingConstant.h12),
      SdPageIndicatorV5(count: widget.banners.length, index: _index),
    ],
  );
}

class _BannerPage extends StatelessWidget {
  const _BannerPage({required this.banner, required this.offset});

  final BannerEntity banner;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final double scale = 1 - (offset.abs() * 0.06).clamp(0, 0.06);

    return Transform.scale(
      scale: scale,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SdSpacingConstant.w6),
        child: SdPressableV5(
          pressedScale: 0.98,
          semanticLabel: banner.title,
          onTap: () => context.push(
            Uri(
              path: AppRoutes.productList.path,
              queryParameters: banner.target.toQuery(),
            ).toString(),
          ),
          child: ClipRRect(
            borderRadius: SdRadiusV5.cardAll,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(offset * -60, 0),
                  child: Transform.scale(
                    scale: 1.2,
                    child: AppImage(banner.image, backdrop: Colors.black),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Colors.black.withValues(alpha: 0.62),
                        Colors.black.withValues(alpha: 0.0),
                      ],
                      stops: const <double>[0, 0.75],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SdSpacingConstant.w20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        banner.eyebrow,
                        style: context.textTheme5.labelSmall!.bold5.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h6),
                      Text(
                        banner.title,
                        style: context.textTheme5.headlineLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h6),
                      Text(
                        banner.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme5.bodySmall!.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      SizedBox(height: SdSpacingConstant.h12),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SdSpacingConstant.w14,
                          vertical: SdSpacingConstant.h8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: SdRadiusV5.fullAll,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              context.loc.action_shop_now,
                              style: context.textTheme5.labelMedium!.bold5
                                  .copyWith(color: Colors.black),
                            ),
                            SizedBox(width: SdSpacingConstant.w4),
                            SdIconV5(
                              Symbols.arrow_forward_rounded,
                              size: SdIconV5.smallSize,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

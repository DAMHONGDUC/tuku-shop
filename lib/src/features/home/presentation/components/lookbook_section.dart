import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Editorial tiles into the women's and men's edits and the eco collection.
class LookbookSection extends StatelessWidget {
  const LookbookSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double tileHeight = MediaQuery.sizeOf(context).width * 0.62;

    return Padding(
      padding: SdContentPaddingV5.gutter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SdSectionHeaderV5(
            title: context.loc.home_lookbook,
            subtitle: context.loc.home_lookbook_subtitle,
          ),
          SizedBox(height: SdSpacingConstant.h14),
          SizedBox(
            height: tileHeight,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _LookTile(
                    image: AppAssets.lookWomenPants,
                    title: context.loc.gender_women,
                    caption: context.loc.home_look_women,
                    args: ProductListArgs(
                      title: context.loc.gender_women,
                      gender: Gender.women,
                    ),
                  ),
                ),
                SizedBox(width: SdContentPaddingV5.gridGap),
                Expanded(
                  child: _LookTile(
                    image: AppAssets.lookMenPants,
                    title: context.loc.gender_men,
                    caption: context.loc.home_look_men,
                    args: ProductListArgs(
                      title: context.loc.gender_men,
                      gender: Gender.men,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SdContentPaddingV5.gridGap),
          SizedBox(
            height: tileHeight * 0.5,
            child: _LookTile(
              image: AppAssets.lookPerformance,
              title: context.loc.home_look_performance,
              caption: context.loc.home_look_performance_caption,
              args: ProductListArgs(
                title: context.loc.home_look_performance,
                sort: ProductSort.topRated,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LookTile extends StatelessWidget {
  const _LookTile({
    required this.image,
    required this.title,
    required this.caption,
    required this.args,
  });

  final String image;
  final String title;
  final String caption;
  final ProductListArgs args;

  @override
  Widget build(BuildContext context) => SdPressableV5(
    semanticLabel: title,
    onTap: () => context.push(AppRoutes.productListPath(args)),
    child: ClipRRect(
      borderRadius: SdRadiusV5.cardAll,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AppImage(image, backdrop: Colors.black),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withValues(alpha: 0),
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const <double>[0.45, 1],
              ),
            ),
          ),
          Positioned(
            left: SdSpacingConstant.w14,
            right: SdSpacingConstant.w14,
            bottom: SdSpacingConstant.h14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: context.textTheme5.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme5.labelMedium!.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

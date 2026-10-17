import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

/// The big average, its stars, and a bar per star count that fills in.
class RatingSummary extends StatelessWidget {
  const RatingSummary({required this.summary, super.key});

  final ReviewSummary summary;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Column(
        children: <Widget>[
          Text(
            summary.average.toStringAsFixed(1),
            style: context.textTheme5.displayMedium,
          ),
          SdRatingV5(
            rating: summary.average,
            semanticLabel: context.loc.detail_rating(
              summary.average.toStringAsFixed(1),
            ),
          ),
          SizedBox(height: SdSpacingConstant.h4),
          Text(
            context.loc.detail_reviews(summary.total),
            style: context.textTheme5.labelMedium!.muted5(context),
          ),
        ],
      ),
      SizedBox(width: SdSpacingConstant.w24),
      Expanded(
        child: Column(
          children: <Widget>[
            for (int stars = 5; stars >= 1; stars--)
              Padding(
                padding: EdgeInsets.symmetric(vertical: SdSpacingConstant.h2),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: SdSpacingConstant.w12,
                      child: Text(
                        '$stars',
                        style: context.textTheme5.labelMedium,
                      ),
                    ),
                    SdIconV5(
                      Symbols.star_rounded,
                      size: SdIconV5.smallSize * 0.8,
                      fill: 1,
                      color: context.sdTheme5.rating,
                    ),
                    SizedBox(width: SdSpacingConstant.w8),
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 0,
                          end: summary.share(stars),
                        ),
                        duration: SdMotionV5.of(context, SdMotionV5.page * 1.5),
                        curve: SdMotionV5.standard,
                        builder: (BuildContext context, double v, Widget? _) =>
                            ClipRRect(
                              borderRadius: SdRadiusV5.fullAll,
                              child: LinearProgressIndicator(
                                value: v,
                                minHeight: SdSpacingConstant.h6,
                                color: context.sdTheme5.textPrimary,
                                backgroundColor: context.sdTheme5.surfaceSunken,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

/// One review: who, when, what they bought, what they said, their photos.
class ReviewTile extends StatelessWidget {
  const ReviewTile({required this.review, super.key});

  final ReviewEntity review;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          SdAvatarV5(initials: review.initials, size: SdSpacingConstant.r36),
          SizedBox(width: SdSpacingConstant.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        review.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme5.labelLarge,
                      ),
                    ),
                    SizedBox(width: SdSpacingConstant.w6),
                    SdIconV5(
                      Symbols.verified_rounded,
                      size: SdIconV5.smallSize * 0.85,
                      fill: 1,
                      color: context.sdTheme5.success,
                    ),
                  ],
                ),
                Text(
                  '${Formatters.date(review.createdAt, context.localeName)} · ${context.loc.review_variant(review.size, review.color)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme5.labelSmall!.faint5(context),
                ),
              ],
            ),
          ),
          SdRatingV5(
            rating: review.rating.toDouble(),
            size: SdIconV5.smallSize * 0.85,
            semanticLabel: context.loc.detail_rating('${review.rating}'),
          ),
        ],
      ),
      SizedBox(height: SdSpacingConstant.h10),
      Text(review.title, style: context.textTheme5.titleSmall),
      SizedBox(height: SdSpacingConstant.h4),
      Text(
        review.comment,
        style: context.textTheme5.bodyMedium!.muted5(context),
      ),
      if (review.photos.isNotEmpty) ...<Widget>[
        SizedBox(height: SdSpacingConstant.h10),
        SizedBox(
          height: SdSpacingConstant.r64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: review.photos.length,
            separatorBuilder: (_, _) => SizedBox(width: SdSpacingConstant.w8),
            itemBuilder: (BuildContext context, int i) => SdPressableV5(
              onTap: () => showPhotoViewer(
                context,
                images: review.photos,
                initialIndex: i,
              ),
              child: SizedBox.square(
                dimension: SdSpacingConstant.r64,
                child: AppImage(
                  review.photos[i],
                  borderRadius: SdRadiusV5.thumbnailAll,
                ),
              ),
            ),
          ),
        ),
      ],
      SizedBox(height: SdSpacingConstant.h8),
      Row(
        children: <Widget>[
          SdIconV5(
            Symbols.thumb_up_rounded,
            size: SdIconV5.smallSize * 0.85,
            color: context.sdTheme5.textTertiary,
          ),
          SizedBox(width: SdSpacingConstant.w4),
          Text(
            context.loc.review_helpful(review.helpfulCount),
            style: context.textTheme5.labelSmall!.faint5(context),
          ),
        ],
      ),
    ],
  );
}

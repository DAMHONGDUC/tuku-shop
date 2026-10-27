import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:system_design/index.dart';

const _kAssetsReviewSize = 100.0;

class ReviewCommentItem extends StatelessWidget {
  const ReviewCommentItem({
    super.key,
    required this.review,
    required this.isLast,
  });

  final ReviewComment review;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // User
            Text(
              review.userName,
              style: SdTextStyleV5.body14().wSemiBold().wColor(
                context.colorTheme.textDefault,
              ),
            ),
            const SdHorizontalSpacingV5(xRatio: 0.5),
            // Rating
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < review.rating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: context.colorTheme.warning,
                  size: 14,
                ),
              ),
            ),
            Spacer(),
            // Date
            Text(
              SdDateTimeHelperV5.dateTimeToDDMMYY(review.createdAt),
              style: SdTextStyleV5.body12().copyWith(
                color: context.colorTheme.textSubTitle,
              ),
            ),
          ],
        ),
        const SdVerticalSpacingV5(xRatio: 0.25),

        // Comment
        Text(
          review.comment,
          style: SdTextStyleV5.body14().wColor(context.colorTheme.textDefault),
        ),
        if (review.colorName.isNotEmpty || review.size.isNotEmpty) ...[
          const SizedBox(height: SdSpacingV5.s4),
          Text(
            context.loc.review_variation(
              [
                review.colorName,
                review.size,
              ].where((v) => v.isNotEmpty && v != 'One size').join(', '),
            ),
            style: SdTextStyleV5.body12().wColor(
              context.colorTheme.textSubTitle,
            ),
          ),
        ],

        const SdVerticalSpacingV5(xRatio: 0.25),

        // Assets (max 2)
        if (review.assets.isNotEmpty) ...[
          const SizedBox(height: SdSpacingV5.s4),
          SizedBox(
            height: _kAssetsReviewSize,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: review.assets.length,
              separatorBuilder: (_, __) => SdHorizontalSpacingV5(),
              itemBuilder: (context, index) {
                final asset = review.assets[index];
                return GestureDetector(
                  onTap: () {
                    final items = review.assets
                        .map(
                          (e) => SdPreviewMediaConfigV5(
                            filePath: e.url,
                            isVideo: e.type == AssetType.video,
                            isAsset: e.url.contains('asset'),
                          ),
                        )
                        .toList();
                    SdPreviewMediaViewV5.show(
                      context: context,
                      items: items,
                      initialIndex: index,
                    );
                  },
                  child: asset.type == AssetType.image
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(SdSpacingV5.s8),
                          child: SdImageV5(
                            imagePath: asset.url,
                            width: _kAssetsReviewSize,
                            height: _kAssetsReviewSize,
                          ),
                        )
                      : SdVideoPlaceHolderV5(
                          videoPath: asset.url,
                          width: _kAssetsReviewSize,
                          height: _kAssetsReviewSize,
                        ),
                );
              },
            ),
          ),
        ],

        if (!isLast) SdVerticalSpacingV5(),
      ],
    );
  }
}

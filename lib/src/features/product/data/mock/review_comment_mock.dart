import 'dart:math';
import 'package:tuku_shop/src/features/product/data/models/review_comment_model.dart';

const kImgReviewPath = 'assets/images/review_comment/';
const kVidReviewPath = 'assets/videos/review_comment/';

class ReviewCommentMock {
  // Fixed seed: the same text on every launch.
  static final _random = Random(7);

  static final _names = [
    'Alice',
    'Bob',
    'Clara',
    'David',
    'Ethan',
    'Fiona',
    'George',
    'Hana',
    'Ivy',
    'Jack',
    'Liam',
    'Mia',
    'Noah',
    'Olivia',
    'Paul',
    'Quinn',
    'Ruby',
    'Sophia',
    'Tom',
    'Uma',
    'Victor',
    'Wendy',
    'Xander',
    'Yara',
    'Zoe',
  ];

  static final _comments = [
    'Great quality, worth the price!',
    'Really stylish and durable.',
    'Perfect size for my needs.',
    'Looks good but could be stronger.',
    'Comfortable and lightweight.',
    'Material feels premium.',
    'Nice design but a bit pricey.',
    'Color is vibrant and beautiful.',
    'Exactly as described, love it!',
    'Could be improved with more pockets.',
    'Fast shipping, very satisfied!',
    'Exceeded my expectations.',
    'Good value for money.',
    'Not as described, a bit disappointed.',
    'Packaging was excellent.',
    'Would definitely buy again.',
    'Customer service was helpful.',
    'Feels cheap, expected better.',
    'Love the texture and finish.',
    'Perfect gift for a friend.',
  ];

  // Assets
  static final _imageAssets = [
    '${kImgReviewPath}img_review_1.jpg',
    '${kImgReviewPath}img_review_2.jpg',
    '${kImgReviewPath}img_review_3.jpg',
    '${kImgReviewPath}img_review_4.jpg',
    '${kImgReviewPath}img_review_5.jpg',
    '${kImgReviewPath}img_review_6.jpg',
    '${kImgReviewPath}img_review_7.jpg',
    '${kImgReviewPath}img_review_8.jpg',
  ];

  static final _videoAssets = [
    '${kVidReviewPath}vid_review_1.mp4',
    '${kVidReviewPath}vid_review_2.mp4',
    '${kVidReviewPath}vid_review_3.mp4',
    '${kVidReviewPath}vid_review_4.mp4',
    '${kVidReviewPath}vid_review_5.mp4',
    '${kVidReviewPath}vid_review_6.mp4',
    '${kVidReviewPath}vid_review_7.mp4',
    '${kVidReviewPath}vid_review_8.mp4',
  ];

  /// Random assets (max 9, image or video)
  static List<ReviewAssetModel> _generateRandomAssets({int max = 5}) {
    final assetCount = _random.nextInt(max + 1);
    final assets = <ReviewAssetModel>[];

    for (int i = 0; i < assetCount; i++) {
      final isImage = _random.nextBool();
      if (isImage) {
        final url = _imageAssets[_random.nextInt(_imageAssets.length)];
        assets.add(ReviewAssetModel(url: url, type: 'image'));
      } else {
        final url = _videoAssets[_random.nextInt(_videoAssets.length)];
        assets.add(ReviewAssetModel(url: url, type: 'video'));
      }
    }
    return assets;
  }

  /// Generate a list of random review comments
  static List<ReviewCommentModel> generateRandomReviews(int count) {
    return List.generate(count, (index) {
      final name = _names[_random.nextInt(_names.length)];
      final comment = _comments[_random.nextInt(_comments.length)];
      final rating = (_random.nextDouble() * 2) + 3; // rating từ 3.0 -> 5.0
      final daysAgo = _random.nextInt(365);
      final date = DateTime.now()
          .subtract(Duration(days: daysAgo))
          .toUtc()
          .toString();
      final assets = _generateRandomAssets();

      return ReviewCommentModel(
        id: (index + 1).toString(),
        userName: name,
        comment: comment,
        rating: double.parse(rating.toStringAsFixed(1)),
        createdAt: date,
        assets: assets,
      );
    });
  }
}

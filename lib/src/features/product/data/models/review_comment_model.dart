class ReviewCommentModel {
  final String? id;
  final String? userName;
  final String? comment;
  final double? rating;
  final String? createdAt;
  final List<ReviewAssetModel>? assets;

  /// The variation the reviewer bought.
  final String? colorName;
  final String? size;

  const ReviewCommentModel({
    this.id,
    this.userName,
    this.comment,
    this.rating,
    this.createdAt,
    this.assets,
    this.colorName,
    this.size,
  });
}

class ReviewAssetModel {
  final String? url;
  final String? type;

  const ReviewAssetModel({this.url, this.type});
}

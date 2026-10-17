class ReviewModel {
  const ReviewModel({
    this.id,
    this.author,
    this.rating,
    this.title,
    this.comment,
    this.createdAt,
    this.size,
    this.color,
    this.helpfulCount,
    this.photos,
  });

  final String? id;
  final String? author;
  final int? rating;
  final String? title;
  final String? comment;
  final String? createdAt;
  final String? size;
  final String? color;
  final int? helpfulCount;
  final List<String>? photos;
}

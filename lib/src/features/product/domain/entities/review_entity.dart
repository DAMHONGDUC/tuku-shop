import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  const ReviewEntity({
    required this.id,
    required this.author,
    required this.rating,
    required this.title,
    required this.comment,
    required this.createdAt,
    required this.size,
    required this.color,
    required this.helpfulCount,
    this.photos = const <String>[],
  });

  final String id;
  final String author;
  final int rating;
  final String title;
  final String comment;
  final DateTime createdAt;
  final String size;
  final String color;
  final int helpfulCount;
  final List<String> photos;

  String get initials => author
      .split(' ')
      .where((String p) => p.isNotEmpty)
      .take(2)
      .map((String p) => p[0])
      .join();

  @override
  List<Object> get props => <Object>[
    id,
    author,
    rating,
    title,
    comment,
    createdAt,
    size,
    color,
    helpfulCount,
    photos,
  ];
}

class ReviewSummary extends Equatable {
  const ReviewSummary({
    required this.average,
    required this.total,
    required this.distribution,
  });

  final double average;
  final int total;

  /// Count of reviews per star, 5 down to 1.
  final Map<int, int> distribution;

  double share(int stars) =>
      total == 0 ? 0 : (distribution[stars] ?? 0) / total;

  @override
  List<Object> get props => <Object>[average, total, distribution];
}

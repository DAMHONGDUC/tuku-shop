class BannerModel {
  const BannerModel({
    this.id,
    this.eyebrow,
    this.title,
    this.subtitle,
    this.image,
    this.target,
  });

  final String? id;
  final String? eyebrow;
  final String? title;
  final String? subtitle;
  final String? image;

  /// The product list query string the banner opens.
  final Map<String, String>? target;
}

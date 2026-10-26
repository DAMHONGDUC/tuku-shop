class SellerModel {
  final String? id;
  final String? name;
  final String? colorHex;
  final double? rating;
  final int? followerCount;
  final int? responseRate;
  final String? location;
  final bool? isOfficial;

  const SellerModel({
    this.id,
    this.name,
    this.colorHex,
    this.rating,
    this.followerCount,
    this.responseRate,
    this.location,
    this.isOfficial,
  });
}

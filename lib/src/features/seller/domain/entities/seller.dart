import 'package:equatable/equatable.dart';

/// A shop on the marketplace: who sells a product and who you chat with.
class Seller extends Equatable {
  final String id;
  final String name;

  /// Avatar fill behind the shop's initials, `#RRGGBB`.
  final String colorHex;
  final double rating;
  final int followerCount;

  /// Share of chats answered, 0–100.
  final int responseRate;
  final String location;

  /// The brand's own store ("Mall" on Shopee).
  final bool isOfficial;

  /// Whether the signed-in shopper follows this shop; [followerCount]
  /// already counts them.
  final bool isFollowed;

  const Seller({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.rating,
    required this.followerCount,
    required this.responseRate,
    required this.location,
    this.isOfficial = false,
    this.isFollowed = false,
  });

  /// Up to two capitals for the avatar: "Aurora Official Store" → "AO".
  String get initials => name
      .split(' ')
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0].toUpperCase())
      .join();

  @override
  List<Object?> get props => [
    id,
    name,
    colorHex,
    rating,
    followerCount,
    responseRate,
    location,
    isOfficial,
    isFollowed,
  ];
}

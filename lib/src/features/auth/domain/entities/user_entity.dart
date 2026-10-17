import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.memberSince,
    required this.points,
    this.avatar,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final DateTime memberSince;

  /// Loyalty points, shown on the profile.
  final int points;

  /// A bundled asset path; null shows initials.
  final String? avatar;

  String get firstName => fullName.split(' ').first;

  String get initials => fullName
      .split(' ')
      .where((String part) => part.isNotEmpty)
      .take(2)
      .map((String part) => part[0].toUpperCase())
      .join();

  @override
  List<Object?> get props => <Object?>[
    id,
    fullName,
    email,
    phone,
    memberSince,
    points,
    avatar,
  ];
}

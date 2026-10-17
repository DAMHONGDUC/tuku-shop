class UserModel {
  const UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.memberSince,
    this.points,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    fullName: json['fullName'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    memberSince: json['memberSince'] as String?,
    points: json['points'] as int?,
    avatar: json['avatar'] as String?,
  );

  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? memberSince;
  final int? points;
  final String? avatar;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'memberSince': memberSince,
    'points': points,
    'avatar': avatar,
  };

  UserModel copyWith({String? fullName, String? email, String? phone}) =>
      UserModel(
        id: id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        memberSince: memberSince,
        points: points,
        avatar: avatar,
      );
}

import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class UserModelToUserEntityMapper {
  const UserModelToUserEntityMapper._();

  static UserEntity toEntity(UserModel model) => UserEntity(
    id: model.id ?? '',
    fullName: model.fullName ?? '',
    email: model.email ?? '',
    phone: model.phone ?? '',
    memberSince: DateTime.tryParse(model.memberSince ?? '') ?? DateTime(2025),
    points: model.points ?? 0,
    avatar: model.avatar,
  );
}

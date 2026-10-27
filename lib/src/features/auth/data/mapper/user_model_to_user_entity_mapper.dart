import 'package:tuku_shop/src/features/auth/data/models/user_model.dart';
import 'package:tuku_shop/src/features/auth/domain/entities/user_entity.dart';

class UserModelToUserEntityMapper {
  const UserModelToUserEntityMapper._();

  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id ?? '',
      fullName: model.fullName ?? '',
      email: model.email ?? '',
      phone: model.phone ?? '',
      avatarUrl: model.avatarUrl ?? '',
    );
  }
}

import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/profile/data/mock/profile_mock.dart';
import 'package:tuku_shop/src/features/profile/data/models/setting_section_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<SettingSectionModel>> getProfileSettings();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl();

  @override
  Future<List<SettingSectionModel>> getProfileSettings() async {
    try {
      await MockLatency.wait();
      return ProfileMock.listSettingSection;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

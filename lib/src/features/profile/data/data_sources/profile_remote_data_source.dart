import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/profile/data/mock/profile_mock.dart';
import 'package:tuku_shop/src/features/profile/data/models/setting_section_model.dart';
import 'package:system_design/index.dart';

abstract class ProfileRemoteDataSource {
  Future<List<SettingSectionModel>> getProfileSettings();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl();

  @override
  Future<List<SettingSectionModel>> getProfileSettings() async {
    try {
      await SdHelperV5.delayLoading();
      return ProfileMock.listSettingSection;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

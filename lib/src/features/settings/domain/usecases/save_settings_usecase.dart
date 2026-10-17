import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class SaveSettingsUsecase implements UseCase<AppSettings, AppSettings> {
  SaveSettingsUsecase(this.repository);

  final SettingsRepository repository;

  @override
  Future<Either<Failure, AppSettings>> call(AppSettings params) =>
      repository.saveSettings(params);
}

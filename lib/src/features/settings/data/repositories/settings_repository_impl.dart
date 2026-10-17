import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this.local);

  final SettingsLocalDataSource local;

  static const String _tag = 'SettingsRepository';

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      return Right<Failure, AppSettings>(local.read());
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Read failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, AppSettings>(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AppSettings>> saveSettings(
    AppSettings settings,
  ) async {
    try {
      await local.write(settings);
      SdLogger.action(_tag, 'Saved', settings.props.join(','));
      return Right<Failure, AppSettings>(settings);
    } catch (e, stackTrace) {
      SdLogger.error(_tag, 'Write failed', error: e, stackTrace: stackTrace);
      return const Left<Failure, AppSettings>(CacheFailure());
    }
  }
}

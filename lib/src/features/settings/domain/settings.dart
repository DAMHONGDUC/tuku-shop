import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';

/// Device preferences. Read before the first frame, so unlike catalog data
/// they skip the mock latency.
abstract class SettingsRepository {
  /// `en`, `vi`, or null for the system language.
  Future<Either<Failure, String?>> getLanguageCode();

  Future<Either<Failure, Unit>> setLanguageCode(String? code);
}

class GetLanguageUsecase implements UseCase<String?, NoParams> {
  final SettingsRepository repository;

  GetLanguageUsecase(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) =>
      repository.getLanguageCode();
}

class SetLanguageUsecase implements UseCase<Unit, String?> {
  final SettingsRepository repository;

  SetLanguageUsecase(this.repository);

  static const supported = {'en', 'vi'};

  @override
  Future<Either<Failure, Unit>> call(String? params) {
    if (params != null && !supported.contains(params)) {
      return Future.value(const Left(ValidationFailure('language')));
    }
    return repository.setLanguageCode(params);
  }
}

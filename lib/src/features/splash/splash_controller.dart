import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

part 'splash_state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController({required this._restoreSession, required this._getSettings})
    : super(const SplashState());

  final RestoreSessionUsecase _restoreSession;
  final GetSettingsUsecase _getSettings;

  /// How long the logo plays before the app moves on, even when the session
  /// is read sooner.
  static const Duration minimumShowTime = Duration(milliseconds: 1900);

  Future<void> start() async {
    final (
      Either<Failure, UserEntity?> session,
      Either<Failure, AppSettings> settings,
      _,
    ) = await (
      _restoreSession(const NoParams()),
      _getSettings(const NoParams()),
      Future<void>.delayed(minimumShowTime),
    ).wait;

    final bool signedIn = session.fold(
      (Failure _) => false,
      (UserEntity? u) => u != null,
    );
    final bool onboardingSeen = settings.fold(
      (Failure _) => false,
      (AppSettings s) => s.onboardingSeen,
    );

    emit(
      SplashState(
        destination: !onboardingSeen
            ? AppRoutes.onboarding
            : signedIn
            ? AppRoutes.home
            : AppRoutes.login,
      ),
    );
  }
}

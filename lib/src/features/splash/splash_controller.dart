import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

part 'splash_state.dart';

final _kSplashMinDurationMs = 1000;

class SplashController extends Cubit<SplashState> {
  SplashController(this._getCurrentUserUsecase) : super(SplashInitialState());

  final GetCurrentUserUsecase _getCurrentUserUsecase;

  Future<void> checkLoginStatus() async {
    // The splash stays up at least this long, however fast the read is.
    final minDuration = SdHelperV5.delay(milliseconds: _kSplashMinDurationMs);
    final result = await _getCurrentUserUsecase.call(NoParams());
    await minDuration;

    result.fold(
      (_) => emit(NotLogInLState()),
      (user) => emit(user == null ? NotLogInLState() : LoggedInLState()),
    );
  }
}

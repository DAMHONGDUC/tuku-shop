import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

part 'session_state.dart';

/// Who is signed in, for every screen that greets them or needs their id.
class SessionController extends Cubit<SessionState> {
  SessionController({
    required WatchUserUsecase watchUser,
    required RestoreSessionUsecase restoreSession,
    required LogoutUsecase logout,
  }) : _restoreSession = restoreSession,
       _logout = logout,
       super(const SessionState()) {
    _subscription = watchUser(const NoParams()).listen(
      (UserEntity? user) => emit(
        SessionState(
          status: user == null
              ? SessionStatus.signedOut
              : SessionStatus.signedIn,
          user: user,
        ),
      ),
    );
  }

  final RestoreSessionUsecase _restoreSession;
  final LogoutUsecase _logout;
  late final StreamSubscription<UserEntity?> _subscription;

  /// Reads the stored session; true when someone is signed in.
  Future<bool> restore() async {
    final Either<Failure, UserEntity?> result = await _restoreSession(
      const NoParams(),
    );

    return result.fold((Failure _) => false, (UserEntity? user) => user != null);
  }

  Future<void> logout() => _logout(const NoParams());

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}

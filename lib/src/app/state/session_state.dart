part of 'session_controller.dart';

enum SessionStatus { unknown, signedIn, signedOut }

class SessionState extends Equatable {
  const SessionState({this.status = SessionStatus.unknown, this.user});

  final SessionStatus status;
  final UserEntity? user;

  @override
  List<Object?> get props => <Object?>[status, user];
}

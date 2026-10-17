part of 'splash_controller.dart';

class SplashState extends Equatable {
  const SplashState({this.destination});

  /// Null while the logo is still playing.
  final AppRoute? destination;

  @override
  List<Object?> get props => <Object?>[destination?.path];
}

import 'package:equatable/equatable.dart';

/// The test account the login screen is pre-filled with.
class DemoAccount extends Equatable {
  const DemoAccount({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

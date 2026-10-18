import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

class RegisterState extends Equatable {
  final Set<RegisterField> errors;
  final bool isSubmitting;
  final bool emailTaken;
  final bool failed;
  final UserEntity? user;

  const RegisterState({
    this.errors = const {},
    this.isSubmitting = false,
    this.emailTaken = false,
    this.failed = false,
    this.user,
  });

  @override
  List<Object?> get props => [errors, isSubmitting, emailTaken, failed, user];
}

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this._registerUsecase) : super(const RegisterState());

  final RegisterUsecase _registerUsecase;

  Future<void> submit(RegisterParams params) async {
    if (state.isSubmitting) return;
    final errors = RegisterUsecase.validate(params);
    if (errors.isNotEmpty) {
      emit(RegisterState(errors: errors));
      return;
    }
    emit(const RegisterState(isSubmitting: true));
    final result = await _registerUsecase.call(params);
    result.fold(
      (f) => emit(
        f == const ValidationFailure('email_taken')
            ? const RegisterState(emailTaken: true)
            : const RegisterState(failed: true),
      ),
      (user) => emit(RegisterState(user: user)),
    );
  }
}

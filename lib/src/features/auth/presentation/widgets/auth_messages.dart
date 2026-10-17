import 'package:flutter/widgets.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../login/login_controller.dart';

/// Localized text for the auth screens' errors.
extension AuthMessages on BuildContext {
  String? fieldError(LoginFieldError? error) => switch (error) {
    null => null,
    LoginFieldError.required => loc.validation_required,
    LoginFieldError.invalidEmail => loc.validation_email,
    LoginFieldError.tooShort => loc.validation_password_short,
    LoginFieldError.mismatch => loc.validation_password_mismatch,
  };

  String failureMessage(Failure failure) => switch (failure) {
    ValidationFailure(code: FailureCodes.invalidCredentials) =>
      loc.auth_error_credentials,
    ValidationFailure(code: FailureCodes.emailTaken) => loc.auth_error_email_taken,
    _ => loc.error_message,
  };
}

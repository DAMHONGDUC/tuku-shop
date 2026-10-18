/// The request was understood but breaks a business rule, e.g. cancelling a
/// shipped order. [message] is a stable code, not user-facing text.
class ValidationException implements Exception {
  const ValidationException(this.message);
  final String message;
}

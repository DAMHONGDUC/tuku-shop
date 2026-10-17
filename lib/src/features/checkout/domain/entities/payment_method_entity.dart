import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

class PaymentMethodEntity extends Equatable {
  const PaymentMethodEntity({
    required this.id,
    required this.type,
    required this.label,
    this.detail,
    this.isDefault = false,
  });

  final String id;
  final PaymentMethodType type;

  /// "Visa", "Apple Pay".
  final String label;

  /// "•••• 4242 · 08/28", an email for PayPal.
  final String? detail;
  final bool isDefault;

  @override
  List<Object?> get props => <Object?>[id, type, label, detail, isDefault];
}

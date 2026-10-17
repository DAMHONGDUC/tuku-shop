part of 'payment_methods_controller.dart';

class PaymentMethodsState extends Equatable {
  const PaymentMethodsState({
    this.status = LoadStatus.loading,
    this.methods = const <PaymentMethodEntity>[],
  });

  final LoadStatus status;
  final List<PaymentMethodEntity> methods;

  @override
  List<Object> get props => <Object>[status, methods];
}

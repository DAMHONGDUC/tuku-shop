import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

part 'payment_methods_state.dart';

class PaymentMethodsController extends Cubit<PaymentMethodsState> {
  PaymentMethodsController({
    required GetPaymentMethodsUsecase getPaymentMethods,
    required SetDefaultPaymentMethodUsecase setDefault,
  }) : _getPaymentMethods = getPaymentMethods,
       _setDefault = setDefault,
       super(const PaymentMethodsState());

  final GetPaymentMethodsUsecase _getPaymentMethods;
  final SetDefaultPaymentMethodUsecase _setDefault;

  Future<void> load() async => _emit(await _getPaymentMethods(const NoParams()));

  Future<void> makeDefault(String id) async => _emit(await _setDefault(id));

  void _emit(Either<Failure, List<PaymentMethodEntity>> result) => result.fold(
    (Failure _) => emit(const PaymentMethodsState(status: LoadStatus.failure)),
    (List<PaymentMethodEntity> m) =>
        emit(PaymentMethodsState(status: LoadStatus.success, methods: m)),
  );
}

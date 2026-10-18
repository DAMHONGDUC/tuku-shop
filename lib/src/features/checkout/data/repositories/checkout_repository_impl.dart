import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl({required this.dataSource});

  final CheckoutRemoteDataSource dataSource;

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Right(await run());
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ShippingMethod>>> getShippingMethods() =>
      _guard(dataSource.getShippingMethods);

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() =>
      _guard(dataSource.getPaymentMethods);

  @override
  Future<Either<Failure, Voucher>> applyVoucher(String code) =>
      _guard(() => dataSource.applyVoucher(code));
}

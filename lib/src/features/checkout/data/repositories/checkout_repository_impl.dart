import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:tuku_shop/src/features/checkout/data/mapper/checkout_mappers.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  const CheckoutRepositoryImpl({required this.dataSource});

  final CheckoutRemoteDataSource dataSource;

  static const String _tag = 'CheckoutRepository';

  Future<Either<Failure, T>> _guard<T>(
    String action,
    Future<T> Function() run,
  ) async {
    try {
      return Right<Failure, T>(await run());
    } catch (e, stackTrace) {
      SdLogger.error(_tag, action, error: e, stackTrace: stackTrace);
      return Left<Failure, T>(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() => _guard(
    'Load addresses failed',
    () async => (await dataSource.getAddresses())
        .map(AddressModelToAddressEntityMapper.toEntity)
        .toList(),
  );

  @override
  Future<Either<Failure, AddressEntity>> saveAddress(AddressEntity address) =>
      _guard(
        'Save address failed',
        () async => AddressModelToAddressEntityMapper.toEntity(
          await dataSource.saveAddress(
            AddressModelToAddressEntityMapper.toModel(address),
          ),
        ),
      );

  @override
  Future<Either<Failure, Unit>> deleteAddress(String id) =>
      _guard('Delete address failed', () async {
        await dataSource.deleteAddress(id);
        return unit;
      });

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods() =>
      _guard(
        'Load payment methods failed',
        () async => (await dataSource.getPaymentMethods())
            .map(PaymentMethodModelToPaymentMethodEntityMapper.toEntity)
            .toList(),
      );

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> setDefaultPaymentMethod(
    String id,
  ) => _guard(
    'Set default payment failed',
    () async => (await dataSource.setDefaultPaymentMethod(id))
        .map(PaymentMethodModelToPaymentMethodEntityMapper.toEntity)
        .toList(),
  );

  @override
  Future<Either<Failure, List<DeliveryOptionEntity>>> getDeliveryOptions() =>
      _guard(
        'Load delivery options failed',
        () async => (await dataSource.getDeliveryOptions())
            .map(DeliveryOptionModelToDeliveryOptionEntityMapper.toEntity)
            .toList(),
      );
}

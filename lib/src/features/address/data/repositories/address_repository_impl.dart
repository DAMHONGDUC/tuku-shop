import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/data/data_sources/address_local_data_source.dart';
import 'package:tuku_shop/src/features/address/data/models/address_model.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';

class AddressRepositoryImpl implements AddressRepository {
  AddressRepositoryImpl({required this.dataSource});

  final AddressLocalDataSource dataSource;

  static AddressEntity _toEntity(AddressModel m) => AddressEntity(
    id: m.id ?? '',
    label: m.label ?? '',
    fullName: m.fullName ?? '',
    phone: m.phone ?? '',
    street: m.street ?? '',
    city: m.city ?? '',
    state: m.state ?? '',
    postalCode: m.postalCode ?? '',
    isDefault: m.isDefault ?? false,
  );

  static AddressModel _toModel(AddressEntity a) => AddressModel(
    id: a.id,
    label: a.label,
    fullName: a.fullName,
    phone: a.phone,
    street: a.street,
    city: a.city,
    state: a.state,
    postalCode: a.postalCode,
    isDefault: a.isDefault,
  );

  Future<Either<Failure, T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Right(await run());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<List<AddressEntity>> _all() async =>
      (await dataSource.getAll()).map(_toEntity).toList();

  /// One request: read, change as entities, store.
  Future<void> _mutate(
    List<AddressEntity> Function(List<AddressEntity>) change,
  ) => dataSource.mutate(
    (models) => change(models.map(_toEntity).toList()).map(_toModel).toList(),
  );

  /// Exactly one default: [defaultId] if given, else the first.
  static List<AddressEntity> _normalize(
    List<AddressEntity> list, [
    String? defaultId,
  ]) {
    if (list.isEmpty) return list;
    final id =
        defaultId ??
        list.where((a) => a.isDefault).firstOrNull?.id ??
        list.first.id;
    final normalized = [
      for (final a in list) a.copyWith(isDefault: a.id == id),
    ];
    normalized.sort(
      (a, b) => a.isDefault == b.isDefault ? 0 : (a.isDefault ? -1 : 1),
    );
    return normalized;
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() =>
      _guard(() async => _normalize(await _all()));

  @override
  Future<Either<Failure, AddressEntity>> save(AddressEntity address) =>
      _guard(() async {
        final saved = address.id.isEmpty
            ? address.copyWith(
                id: 'addr-${DateTime.now().microsecondsSinceEpoch}',
              )
            : address;
        await _mutate((all) {
          final exists = all.any((a) => a.id == saved.id);
          final next = exists
              ? [for (final a in all) a.id == saved.id ? saved : a]
              : [...all, saved];
          return _normalize(next, saved.isDefault ? saved.id : null);
        });
        return saved;
      });

  @override
  Future<Either<Failure, Unit>> delete(String id) => _guard(() async {
    await _mutate((all) => _normalize(all.where((a) => a.id != id).toList()));
    return unit;
  });

  @override
  Future<Either<Failure, Unit>> setDefault(String id) => _guard(() async {
    await _mutate((all) => _normalize(all, id));
    return unit;
  });

  @override
  Future<Either<Failure, Unit>> reset() => _guard(() async {
    await dataSource.reset();
    return unit;
  });
}

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:tuku_shop/src/features/cart/data/models/cart_line_model.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required this.dataSource});

  final CartLocalDataSource dataSource;
  final _changes = StreamController<List<CartLine>>.broadcast();
  List<CartLine>? _cache;

  static CartLine _toEntity(CartLineModel m) => CartLine(
    productId: m.productId ?? '',
    name: m.name ?? '',
    brand: m.brand ?? '',
    imageUrl: m.imageUrl ?? '',
    colorName: m.colorName ?? '',
    size: m.size ?? '',
    unitPrice: m.unitPrice ?? 0,
    originalPrice: m.originalPrice,
    quantity: m.quantity ?? 1,
    maxQuantity: m.maxQuantity ?? 10,
  );

  static CartLineModel _toModel(CartLine l) => CartLineModel(
    productId: l.productId,
    name: l.name,
    brand: l.brand,
    imageUrl: l.imageUrl,
    colorName: l.colorName,
    size: l.size,
    unitPrice: l.unitPrice,
    originalPrice: l.originalPrice,
    quantity: l.quantity,
    maxQuantity: l.maxQuantity,
  );

  Future<List<CartLine>> _lines() async =>
      _cache ??= (await dataSource.getLines()).map(_toEntity).toList();

  Future<Either<Failure, List<CartLine>>> _write(
    List<CartLine> Function(List<CartLine> current) change,
  ) async {
    try {
      final next = List<CartLine>.unmodifiable(change(await _lines()));
      await dataSource.saveLines(next.map(_toModel).toList());
      _cache = next;
      _changes.add(next);
      return Right(next);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Stream<List<CartLine>> watchLines() => _changes.stream;

  @override
  Future<Either<Failure, List<CartLine>>> getLines() async {
    try {
      return Right(List.unmodifiable(await _lines()));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<CartLine>>> add(CartLine line) =>
      _write((current) {
        final existing = current.where((l) => l.id == line.id).firstOrNull;
        if (existing == null) return [line, ...current];
        final quantity = (existing.quantity + line.quantity).clamp(
          1,
          line.maxQuantity,
        );
        return [
          for (final l in current)
            l.id == line.id ? line.copyWith(quantity: quantity) : l,
        ];
      });

  @override
  Future<Either<Failure, List<CartLine>>> updateQuantity(
    String lineId,
    int quantity,
  ) => _write(
    (current) => [
      for (final l in current)
        l.id == lineId
            ? l.copyWith(quantity: quantity.clamp(1, l.maxQuantity))
            : l,
    ],
  );

  @override
  Future<Either<Failure, List<CartLine>>> remove(String lineId) =>
      _write((current) => current.where((l) => l.id != lineId).toList());

  @override
  Future<Either<Failure, List<CartLine>>> removeLines(Set<String> lineIds) =>
      _write(
        (current) => current.where((l) => !lineIds.contains(l.id)).toList(),
      );

  @override
  Future<Either<Failure, Unit>> reset() async {
    try {
      await dataSource.reset();
      _cache = null;
      _changes.add(List.unmodifiable(await _lines()));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRepositoryImpl({required this.dataSource});

  final WishlistLocalDataSource dataSource;
  final _changes = StreamController<List<String>>.broadcast();
  List<String>? _cache;

  Future<List<String>> _ids() async => _cache ??= await dataSource.getIds();

  @override
  Stream<List<String>> watchIds() => _changes.stream;

  @override
  Future<Either<Failure, List<String>>> getIds() async {
    try {
      // Always a fresh read, so pull-to-refresh behaves like the network.
      _cache = await dataSource.getIds();
      return Right(List.unmodifiable(_cache!));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> toggle(String productId) async {
    try {
      final current = await _ids();
      final saved = current.contains(productId);
      final next = saved
          ? current.where((id) => id != productId).toList()
          : [productId, ...current];
      await dataSource.saveIds(next);
      _cache = next;
      _changes.add(List.unmodifiable(next));
      return Right(!saved);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> reset() async {
    try {
      await dataSource.reset();
      _cache = null;
      _changes.add(List.unmodifiable(await _ids()));
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

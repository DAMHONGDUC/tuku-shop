import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:system_design/common.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRepositoryImpl(this.local);

  final WishlistLocalDataSource local;

  final StreamController<List<String>> _changes =
      StreamController<List<String>>.broadcast();
  List<String>? _ids;

  List<String> get _current => _ids ??= local.read();

  @override
  Stream<List<String>> watch() async* {
    yield _current;
    yield* _changes.stream;
  }

  @override
  Future<Either<Failure, bool>> toggle(String productId) async {
    try {
      final bool saved = !_current.contains(productId);
      final List<String> next = saved
          ? <String>[productId, ..._current]
          : _current.where((String id) => id != productId).toList();

      _ids = next;
      _changes.add(next);
      await local.write(next);
      SdLogger.action(
        'WishlistRepository',
        saved ? 'Saved' : 'Removed',
        productId,
      );

      return Right<Failure, bool>(saved);
    } catch (e, stackTrace) {
      SdLogger.error(
        'WishlistRepository',
        'Toggle failed',
        error: e,
        stackTrace: stackTrace,
      );
      return const Left<Failure, bool>(CacheFailure());
    }
  }
}

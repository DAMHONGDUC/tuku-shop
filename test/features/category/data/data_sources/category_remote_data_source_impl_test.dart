import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/category/data/data_sources/category_remote_data_source_impl.dart';

void main() {
  test('getCategories answers after the mock latency, not before', () {
    fakeAsync((async) {
      Object? result;
      const CategoryRemoteDataSourceImpl().getCategories().then(
        (value) => result = value,
      );

      async.elapse(MockLatency.duration - const Duration(milliseconds: 1));
      expect(result, isNull);

      async.elapse(const Duration(milliseconds: 1));
      expect(result, isNotNull);
    });
  });
}

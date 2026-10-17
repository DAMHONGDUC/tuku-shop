import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';

void main() {
  test('MockLatency.wait completes after exactly 1 second', () {
    fakeAsync((async) {
      var done = false;
      MockLatency.wait().then((_) => done = true);

      async.elapse(const Duration(milliseconds: 999));
      expect(done, isFalse);

      async.elapse(const Duration(milliseconds: 1));
      expect(done, isTrue);
    });
  });
}

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/core.dart';

void main() {
  test('every delay falls between 200 and 800 ms', () {
    for (var i = 0; i < 200; i++) {
      final delay = MockLatency.next();
      expect(delay, greaterThanOrEqualTo(MockLatency.min));
      expect(delay, lessThanOrEqualTo(MockLatency.max));
    }
  });

  test('MockLatency.wait is never done before min and always by max', () {
    fakeAsync((async) {
      var done = false;
      MockLatency.wait().then((_) => done = true);

      async.elapse(MockLatency.min - const Duration(milliseconds: 1));
      expect(done, isFalse);

      async.elapse(MockLatency.max - MockLatency.min);
      expect(done, isTrue);
    });
  });
}

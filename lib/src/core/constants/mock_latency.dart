import 'dart:math';

/// The fake network delay every mock data source waits before answering:
/// between [min] and [max], so sections land at slightly different moments
/// like a real API.
///
/// The only place latency lives: controllers, usecases and repositories never
/// delay on their own.
class MockLatency {
  const MockLatency._();

  static const min = Duration(milliseconds: 300);
  static const max = Duration(milliseconds: 700);

  // Fixed seed: the same sequence of waits on every launch.
  static final _random = Random(3);

  /// One delay in [min]..[max], inclusive.
  static Duration next() =>
      min +
      Duration(
        milliseconds: _random.nextInt(
          max.inMilliseconds - min.inMilliseconds + 1,
        ),
      );

  static Future<void> wait() => Future<void>.delayed(next());
}

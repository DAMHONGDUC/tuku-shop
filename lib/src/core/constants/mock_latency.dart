/// The fake network delay every mock data source waits before answering.
///
/// The only place latency lives: controllers, usecases and repositories never
/// delay on their own.
class MockLatency {
  const MockLatency._();

  static const duration = Duration(seconds: 1);

  static Future<void> wait() => Future<void>.delayed(duration);
}

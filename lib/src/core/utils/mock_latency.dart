import 'dart:math';

/// Stands in for the network: every mock data source awaits this, so the
/// demo shows its skeletons and spinners the way a real backend would.
abstract final class MockLatency {
  static final Random _random = Random();

  /// Zero under test, so suites run instantly.
  static bool enabled = true;

  static Future<void> short() => _wait(250, 450);

  static Future<void> normal() => _wait(450, 900);

  static Future<void> long() => _wait(1000, 1600);

  static Future<void> _wait(int min, int max) {
    if (!enabled) return Future<void>.value();

    return Future<void>.delayed(
      Duration(milliseconds: min + _random.nextInt(max - min)),
    );
  }
}

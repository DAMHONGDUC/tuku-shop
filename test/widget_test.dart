import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuku_shop/src/app/tuku_app.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';

/// Smoke test: the whole DI graph resolves and the app builds its first frame.
void main() {
  setUpAll(() => MockLatency.enabled = false);

  tearDown(() => getIt.reset());

  testWidgets('TukuApp builds on a fresh install', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await Injector.config();

    await tester.pumpWidget(const TukuApp());
    await tester.pump();

    expect(find.byType(TukuApp), findsOneWidget);
    expect(tester.takeException(), isNull);

    // Let the splash's minimum show time and any route change run out.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 10),
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/resources/custom_theme_ext/app_color_theme_ext.dart';
import 'package:tuku_shop/src/core/widgets/misc/swipe_action.dart';

void main() {
  late int actions;

  Future<void> pumpRow(WidgetTester tester) {
    actions = 0;
    return tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(extensions: [AppColorThemeExt.light()]),
        home: Scaffold(
          body: SwipeAction(
            label: 'Delete',
            onAction: () => actions++,
            child: const SizedBox(height: 80, child: Text('Row')),
          ),
        ),
      ),
    );
  }

  testWidgets('a swipe only reveals the action', (tester) async {
    await pumpRow(tester);

    await tester.drag(find.text('Row'), const Offset(-200, 0));
    await tester.pumpAndSettle();

    expect(actions, 0);
    expect(tester.getTopLeft(find.text('Row')).dx, -SwipeAction.actionWidth);
  });

  testWidgets('tapping the revealed action runs it and closes', (tester) async {
    await pumpRow(tester);
    await tester.drag(find.text('Row'), const Offset(-200, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(actions, 1);
    expect(tester.getTopLeft(find.text('Row')).dx, 0);
  });

  testWidgets('a short drag springs back closed', (tester) async {
    await pumpRow(tester);

    await tester.timedDrag(
      find.text('Row'),
      const Offset(-20, 0),
      const Duration(milliseconds: 500),
    );
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(find.text('Row')).dx, 0);
  });

  testWidgets('tapping an open row closes it without the action', (
    tester,
  ) async {
    await pumpRow(tester);
    await tester.drag(find.text('Row'), const Offset(-200, 0));
    await tester.pumpAndSettle();

    // A visible point of the slid row, left of the revealed action.
    await tester.tapAt(const Offset(200, 40));
    await tester.pumpAndSettle();

    expect(actions, 0);
    expect(tester.getTopLeft(find.text('Row')).dx, 0);
  });
}

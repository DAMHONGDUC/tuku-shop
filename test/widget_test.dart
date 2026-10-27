import 'package:tuku_shop/src/core/resources/custom_theme_ext/app_color_theme_ext.dart';
import 'package:tuku_shop/src/core/widgets/empty/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyView renders the given message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        // EmptyView only reads context.colorTheme (AppColorThemeExt).
        theme: ThemeData(extensions: [AppColorThemeExt.light()]),
        home: const Scaffold(body: EmptyView(message: 'No data available')),
      ),
    );

    expect(find.text('No data available'), findsOneWidget);
  });
}

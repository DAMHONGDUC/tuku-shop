import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/variant_section/variant_selection_controller.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  late VariantSelectionController controller;

  setUp(() => controller = VariantSelectionController()..init(tProduct()));
  tearDown(() => controller.close());

  test('starts on the first color with no size picked', () {
    expect(controller.state.colorName, 'Black');
    expect(controller.state.size, isNull);
    expect(controller.state.canAddToCart, isFalse);
  });

  test('a sold-out size cannot be picked', () {
    controller.selectSize('M');
    expect(controller.state.size, isNull);
    expect(controller.state.isSizeAvailable('M'), isFalse);
  });

  test('quantity is capped by stock', () {
    controller.selectSize('S'); // 3 left
    controller
      ..increment()
      ..increment()
      ..increment();
    expect(controller.state.quantity, 3);
    controller.decrement();
    expect(controller.state.quantity, 2);
  });

  test('switching color keeps the size only if it is in stock there', () {
    controller.selectSize('L');
    controller.selectColor('White'); // White L is sold out
    expect(controller.state.size, isNull);

    controller.selectSize('S');
    controller.selectColor('Black'); // Black S has stock
    expect(controller.state.size, 'S');
    expect(controller.state.quantity, 1);
  });
}

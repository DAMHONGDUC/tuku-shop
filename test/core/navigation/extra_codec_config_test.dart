import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tuku_shop/src/core/navigation/extra_codec_config.dart';

class _Entity {
  const _Entity();
}

void main() {
  const codec = ExtraCodecConfig();

  test('an extra with no JSON form encodes to null instead of throwing', () {
    final encoded = codec.encode(const _Entity());
    expect(encoded, isNull);
    expect(() => jsonEncode(encoded), returnsNormally);
  });

  test('lists and maps keep their encodable parts', () {
    final encoded = codec.encode({
      'ids': ['a', 'b'],
      'entity': const _Entity(),
    });
    expect(() => jsonEncode(encoded), returnsNormally);
    expect(codec.decode(jsonDecode(jsonEncode(encoded))), {
      'ids': ['a', 'b'],
      'entity': null,
    });
  });
}

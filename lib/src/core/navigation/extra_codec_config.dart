import 'dart:convert';

import 'package:system_design/index.dart';

import 'package:tuku_shop/src/features/product/presentation/product_detail/product_detail_args.dart';

class ExtraCodecConfig extends Codec<Object?, Object?> {
  const ExtraCodecConfig();

  @override
  Converter<Object?, Object?> get decoder => const _ExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _ExtraEncoder();
}

class _ExtraEncoder extends Converter<Object?, Object?> {
  const _ExtraEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;

    return switch (input) {
      ProductDetailArgs args => {
        'type': 'ProductDetailArgs',
        'data': args.toJson(),
      },
      List list => {
        'type': 'List',
        'data': list.map((e) => convert(e)).toList(),
      },
      Map map => {
        'type': 'Map',
        'data': map.map(
          (key, value) => MapEntry(key.toString(), convert(value)),
        ),
      },
      // Primitive types pass through
      String() || int() || double() || bool() => input,
      // go_router encodes `extra` on every navigation to report the route to
      // the platform; in-app navigation keeps the original object. A type
      // with no JSON form is left out instead of crashing jsonEncode, so
      // pass ids or primitives when a route must survive a restore.
      _ => _skip(input),
    };
  }

  static Object? _skip(Object input) {
    SdLogV5.d('Route extra ${input.runtimeType} has no JSON form; not encoded');
    return null;
  }
}

class _ExtraDecoder extends Converter<Object?, Object?> {
  const _ExtraDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;

    // Check if it's a typed object
    if (input is Map<String, dynamic> && input.containsKey('type')) {
      final type = input['type'] as String;
      final data = input['data'];

      switch (type) {
        case 'ProductDetailArgs':
          return ProductDetailArgs.fromJson(data as Map<String, dynamic>);
        case 'List':
          return (data as List).map((e) => convert(e)).toList();
        case 'Map':
          return (data as Map).map(
            (key, value) => MapEntry(key, convert(value)),
          );
        default:
          return input;
      }
    }

    return input;
  }
}

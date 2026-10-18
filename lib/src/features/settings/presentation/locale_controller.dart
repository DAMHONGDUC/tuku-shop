import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

/// The app language; null follows the device.
class LocaleController extends Cubit<Locale?> {
  LocaleController(this._getLanguage, this._setLanguage) : super(null);

  final GetLanguageUsecase _getLanguage;
  final SetLanguageUsecase _setLanguage;

  Future<void> load() async {
    final result = await _getLanguage.call(NoParams());
    result.fold((_) {}, (code) => emit(code == null ? null : Locale(code)));
  }

  Future<void> select(String? code) async {
    final before = state;
    emit(code == null ? null : Locale(code));
    final result = await _setLanguage.call(code);
    result.fold((_) => emit(before), (_) {});
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/settings/domain/domain.dart';

/// Theme, language and the onboarding flag. The whole app rebuilds from it.
class SettingsController extends Cubit<AppSettings> {
  SettingsController({required this._getSettings, required this._saveSettings})
    : super(const AppSettings());

  final GetSettingsUsecase _getSettings;
  final SaveSettingsUsecase _saveSettings;

  ThemeMode get themeMode => switch (state.theme) {
    ThemePreference.system => ThemeMode.system,
    ThemePreference.light => ThemeMode.light,
    ThemePreference.dark => ThemeMode.dark,
  };

  Locale get locale => Locale(state.languageCode);

  Future<void> load() async {
    final Either<Failure, AppSettings> result = await _getSettings(
      const NoParams(),
    );
    result.fold((Failure _) {}, emit);
  }

  Future<void> update(AppSettings settings) async {
    emit(settings);
    await _saveSettings(settings);
  }

  Future<void> setTheme(ThemePreference theme) =>
      update(state.copyWith(theme: theme));

  Future<void> setLanguage(String code) =>
      update(state.copyWith(languageCode: code));

  Future<void> completeOnboarding() =>
      update(state.copyWith(onboardingSeen: true));
}

# Short names for the shared scripts in packages/script-tools/flutter. `make` lists them.
SCRIPT_TOOLS := packages/script-tools
include $(SCRIPT_TOOLS)/flutter/flutter.mk

# App-only targets; the shared ones above cover set-up, gen, analyze and test.
.PHONY: run format format-check apk

run: ## flutter run on the selected device
	@fvm flutter run

format: ## dart format the app and its packages
	@fvm dart format lib test packages/flutter-system-design-kit/lib packages/flutter-system-design-kit/test

format-check: ## Fail when a file is not formatted (CI)
	@fvm dart format --set-exit-if-changed lib test packages/flutter-system-design-kit/lib packages/flutter-system-design-kit/test

apk: ## Release APK named release_<date>.apk in build/app/outputs/flutter-apk
	@bash bash/build_apk.sh

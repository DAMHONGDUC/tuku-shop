# Make targets

The [Makefile](../../Makefile) includes `packages/script-tools/flutter/flutter.mk`; `make` lists every target. Melos only bootstraps the workspace.

| Target | What it does |
|---|---|
| `make set-up` | Wipe build outputs, submodules onto their branch, `pub get` (app + `packages/*`), l10n |
| `make deep-set-up` | `set-up` + this project's Xcode DerivedData |
| `make gen` | Regenerate localizations (`flutter gen-l10n`) |
| `make analyze` | `flutter analyze --fatal-infos` (the CI gate) |
| `make test` | Whole app suite |
| `make test TEST=<path>` | One test file or folder |
| `make run` | `fvm flutter run` |
| `make format` / `make format-check` | `dart format` app + kit / fail when unformatted |
| `make apk` | Release APK `build/app/outputs/flutter-apk/release_<date>.apk` ([bash/build_apk.sh](../../bash/build_apk.sh)) |
| `make app-icon` | Launcher icons from `assets/images/app_icon.png` |

## Design-system submodule

`packages/flutter-system-design-kit` is versioned by its commit pointer.

| # | Step |
|---|---|
| 1 | Commit and push the change inside the kit first |
| 2 | `git add packages/flutter-system-design-kit` in the app and commit the new pointer |
| 3 | `make analyze` and `make test` |

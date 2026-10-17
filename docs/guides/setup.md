# Setup

## Toolchain

| Tool | Version |
|---|---|
| Flutter (via FVM, `.fvmrc`) | 3.44.5 |
| Dart | 3.12.2 |
| Android Studio | 2024.3 |
| Java | 17.0.12 LTS |
| Xcode | 26.4 |
| CocoaPods | 1.16.2 |

## First run

| # | Command | Purpose |
|---|---|---|
| 1 | `git clone --recurse-submodules https://github.com/DAMHONGDUC/dutuku_e_commerce.git` | Clone with the design-system submodule |
| 2 | `fvm install` | Install the pinned Flutter |
| 3 | `make set-up` | Clean, submodules on their branch, pub get, codegen |
| 4 | `fvm flutter run` | Run the app |

Rerun step 3 after every `git pull`.

## Make targets

`Makefile` includes `packages/script-tools/flutter/flutter.mk`; `make` lists every target.

| Command | Runs |
|---|---|
| `make set-up` / `make deep-set-up` | `set_up.sh` / plus this project's Xcode DerivedData |
| `make gen` | l10n + build_runner |
| `make analyze` | `flutter analyze --fatal-infos` |
| `make test [TEST=<path>]` | `flutter test`, one file or folder with `TEST` |
| `make env-<flavor>` | `env_assets/` → `env/`, `ios/`, `android/` (flavors: `dev`, `prod`) |
| `make build-ipa-<flavor>` / `release-<flavor>` / `upload-ipa-<flavor>` | iOS release; needs `ios/fastlane/Fastfile` (TODO: confirm, not set up yet) |

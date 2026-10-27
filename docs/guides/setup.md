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
| `make build-ios-<flavor>` | Release IPA into `build/ios/ipa` |
| `make release-ios-<flavor> [NOTE="..."]` | Build, bump the build number, upload to TestFlight (fastlane `beta`) |
| `make upload-ios-<flavor>` | Upload the IPA already built (fastlane `upload`) |

## iOS release

Lanes come from `packages/script-tools/flutter/fastlane/Fastfile`; `ios/fastlane/Fastfile` only declares team `WNG5UWNJ6H` and bundle id `app.dd.tuku.shop`.

| Step | Command |
|---|---|
| Credentials (once per machine) | `cp ios/fastlane/.env.example ios/fastlane/.env`, then fill the six keys |
| Distribution certificate (once per team) | `cd ios && bundle exec fastlane certificates` |
| Check without building | `cd ios && bundle exec fastlane preflight flavor:dev` |
| Release | `make release-ios-dev NOTE="..."`, then commit the bumped `pubspec.yaml` |

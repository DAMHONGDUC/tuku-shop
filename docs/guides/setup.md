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
| 3 | `fvm dart run melos run setup` | Submodules + deep clean + pub get + codegen |
| 4 | `fvm flutter run` | Run the app |

Rerun step 3 after every `git pull`.

## Firebase config files

| File | Platform | Registered app ID |
|---|---|---|
| `android/app/google-services.json` | Android | `com.dd.tuku.shop` |
| `ios/Runner/GoogleService-Info.plist` | iOS | `app.dd.tuku.shop` |

Both files are gitignored; download them from the Firebase console (project `dutuku-e-commerce`).

# Setup

## Toolchain

| Tool | Version |
|---|---|
| Flutter (via FVM, `.fvmrc`) | 3.47.2 |
| Dart | 3.13.2 |
| Android Studio | 2024.3 |
| Java | 17.0.12 LTS |
| Xcode | 26.4 |
| CocoaPods | 1.16.2 |

## First run

| # | Command | Purpose |
|---|---|---|
| 1 | `git clone --recurse-submodules https://github.com/DAMHONGDUC/dutuku_e_commerce.git` | Clone with both submodules |
| 2 | `git submodule update --init --recursive` | Only for a clone made without `--recurse-submodules` |
| 3 | `fvm install 3.47.2 && fvm use 3.47.2` | Install the pinned Flutter |
| 4 | `make set-up` | Wipe build outputs, submodules, `pub get`, l10n |
| 5 | `make run` | Run the app |

Rerun step 4 after every `git pull`. All commands: [make.md](make.md).

## Submodules

| Path | Repo | `make set-up` checks out |
|---|---|---|
| `packages/flutter-system-design-kit` | [flutter-system-design-kit](https://github.com/DAMHONGDUC/flutter-system-design-kit) | `main` (from `.gitmodules`) |
| `packages/script-tools` | [script-tools](https://github.com/DAMHONGDUC/script-tools) | `main` |

`make set-up` moves the kit onto `main`. Until kit PR #1 (v5) is merged, check out `feat/v5-shop` in the kit by hand afterwards, or the app will not compile.

## Demo data

| What | Value |
|---|---|
| Demo account | `demo@tukushop.com` / `Tuku@2026` |
| Promo codes | `TUKU10`, `WELCOME20` (subtotal $100+), `FREESHIP` |

## Firebase config files

| File | Platform | Registered app ID |
|---|---|---|
| `android/app/google-services.json` | Android | `com.dd.tuku.shop` |
| `ios/Runner/GoogleService-Info.plist` | iOS | `app.dd.tuku.shop` |

Both files are gitignored; download them from the Firebase console (project `dutuku-e-commerce`). The iOS build fails without the plist, because `Runner.xcodeproj` lists it as a bundle resource; with it present but Firebase unreachable, the bootstrap logs the error and the app runs on.

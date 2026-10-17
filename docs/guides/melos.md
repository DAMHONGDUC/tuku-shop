# Melos workspace

The app (root) and every package under `packages/` form one [Melos](https://melos.invertase.dev) workspace; scripts live in [melos.yaml](../../melos.yaml).

## Scripts

Prefix every script with `fvm dart run` (melos is a dev dependency).

| Script | What it does |
|---|---|
| `melos run setup` | Submodule checkout (latest `main`) + deep clean + bootstrap + all codegen |
| `melos bootstrap` | `pub get` in every package |
| `melos run analyze` | `flutter analyze --no-fatal-infos` in every package |
| `melos run test` | `flutter test` in every package with a `test/` folder |
| `melos run format` | Format all packages |
| `melos run format:check` | Fail on unformatted code (CI) |
| `melos run gen:l10n` | Generate localizations (app only) |
| `melos run gen:build` | `build_runner` in packages that depend on it |
| `melos run gen:all` | `gen:l10n` + `gen:build` |
| `melos run clean:flutter` | `flutter clean` in every package |
| `melos run clean:deep` | `clean:flutter` + remove iOS `Pods/` and `Podfile.lock` |

## Design-system submodule

`packages/flutter-system-design-kit` (package `system_design`, app uses generation `v5`) is versioned by its commit pointer; melos versioning/publishing is not used.

| # | Step |
|---|---|
| 1 | `git submodule update --remote packages/flutter-system-design-kit` |
| 2 | Verify the app builds |
| 3 | `git add packages/flutter-system-design-kit` and commit the new pointer |

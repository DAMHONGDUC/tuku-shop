# CI/CD

## Workflows

| Workflow | Trigger | Steps |
|---|---|---|
| [ci.yml](../.github/workflows/ci.yml) | Push / PR to `main` | Flutter 3.47.2 → `pub get` → script-tools `generate_code.sh` → `analyze_code.sh` → `run_tests.sh` → kit `flutter test` (no secrets) |
| [deploy.yml](../.github/workflows/deploy.yml) | Manual (`workflow_dispatch`) | Restore signing/config files from secrets → Fastlane → Firebase App Distribution |

| Job | Status |
|---|---|
| `deploy-android` | Fully wired |
| `deploy-ios` | Gated by repo variable `IOS_DEPLOY_ENABLED` until Apple signing secrets exist |

## Required secrets

| Secret | Used by | Value |
|---|---|---|
| `ANDROID_KEYSTORE_BASE64` | Android | `base64 android/app/tuku-shop-upload-keystore.jks` |
| `ANDROID_KEYSTORE_PASSWORD` | Android | `storePassword` from `android/key.properties` |
| `ANDROID_KEY_PASSWORD` | Android | `keyPassword` from `android/key.properties` |
| `ANDROID_KEY_ALIAS` | Android | `keyAlias` from `android/key.properties` |
| `ANDROID_GOOGLE_SERVICES_JSON_BASE64` | Android | `base64 android/app/google-services.json` |
| `IOS_GOOGLE_SERVICE_INFO_PLIST_BASE64` | iOS | `base64 ios/Runner/GoogleService-Info.plist` |
| `FIREBASE_SERVICE_ACCOUNT_JSON_BASE64` | Both | base64 of a service account JSON with "Firebase App Distribution Admin" role |
| `ENV_DART_DEFINE_JSON_BASE64` | Both, optional | `base64 env/dev.json`, passed as `--dart-define-from-file` |
| `APPLE_TEAM_ID` | iOS | Apple Developer Team ID |
| `APPLE_PROVISIONING_PROFILE_NAME` | iOS | Ad-hoc provisioning profile name (for `app.dd.tuku.shop`) |
| `APPLE_PROVISIONING_PROFILE_BASE64` | iOS | `base64` of the `.mobileprovision` file |
| `APPLE_CERTIFICATE_BASE64` | iOS | `base64` of the distribution certificate `.p12` |
| `APPLE_CERTIFICATE_PASSWORD` | iOS | Password for the `.p12` |

## Repo variables

| Variable | Default |
|---|---|
| `FIREBASE_DISTRIBUTION_GROUPS` | `testers` |
| `IOS_DEPLOY_ENABLED` | `false` |

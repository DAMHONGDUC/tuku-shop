# Architecture

Feature-based Clean Architecture: each feature owns its `domain` / `data` / `presentation` slice under [lib/src/features/](../lib/src/features/).

## Folders

| Path | Contents |
|---|---|
| `lib/src/app/` | `tuku_app.dart`, `app_router.dart`, `shell/` (tab bar), `state/` (app-wide singleton Cubits) |
| `lib/src/features/auth/`, `product/`, `cart/`, `checkout/`, `order/`, `wishlist/`, `notification/`, `banner/`, `category/`, `settings/` | Feature slices |
| `lib/src/features/profile/` | Presentation only: Profile tab, edit profile, settings, help center |
| `lib/src/features/home/` | Presentation only: composes banner / category / product sections |
| `lib/src/features/splash/`, `onboarding/` | Screen flows |
| `lib/src/core/` | Constants, enums, exceptions, failures, l10n, navigation (`AppRoutes`, route args), resources, usecase base, utils, shared widgets |
| `lib/src/di/injector.dart` | Calls each feature's `<Feature>Di.config()` |

## Feature layers

| Layer | Contents |
|---|---|
| `domain/` | Entities, repository contract, usecases, `domain.dart` barrel |
| `data/` | Models (DTOs), mappers, mock, data sources, repository impl |
| `presentation/` | Screens, Cubit controllers/states, feature-local widgets |

## Dependency rule

```mermaid
flowchart LR
  presentation --> domain
  data --> domain
  featureA[featureA.domain] -->|shared concepts only| featureB[featureB.domain]
```

A feature exposes only its `domain/domain.dart` barrel, except to the presentation-only `home/`, which composes other features' sections. Navigation goes through `AppRoutes` in `core/navigation/`.

## Data flow

```mermaid
sequenceDiagram
  participant UI
  participant Cubit
  participant UseCase
  participant Repo as Repository impl
  participant DS as Data source (mock)
  UI->>Cubit: user action
  Cubit->>UseCase: call
  UseCase->>Repo: via repository contract
  Repo->>DS: fetch
  DS-->>Repo: models
  Repo-->>UseCase: Either<Failure, Entity>
  UseCase-->>Cubit: Either<Failure, Entity>
  Cubit-->>UI: emit new state
```

`data/mock/*` stands in for a real API; swapping it only touches that feature's `data` layer.

## Backend DB design

| Resource | Link |
|---|---|
| DB design (Google Drive) | https://drive.google.com/file/d/1vY04Wm6R2z69D4JhJ8cdIqszU7TTXFpA/view?usp=sharing |

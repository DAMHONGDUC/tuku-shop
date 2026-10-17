# Tuku Shop

| | |
|---|---|
| Overview | Flutter e-commerce shopping app (*tuku* = "to buy" in Javanese), UI based on the [Kutuku Figma template](https://www.figma.com/design/MWXnUlavawxNQSMaYIsRRh/Kutuku----eCommerce-Mobile-App-UI-Kit-Figma-High-Quality-Template--Community-?node-id=0-1&p=f) |
| Last edit | 2026-10-17 |
| Author | Dam Hong Duc |

## Store links

| Platform | Link |
|---|---|
| App Store | Not published |
| Google Play | Not published |

## App IDs

| ID | Value |
|---|---|
| iOS bundle ID | `app.dd.tuku.shop` |
| Android app ID | `com.dd.tuku.shop` |
| Android namespace | `com.dd.tuku.shop` |

## Tech stack

| Category | Technology | Version |
|---|---|---|
| Framework | Flutter | 3.47.2 |
| Language | Dart | 3.13.2 |
| State management | flutter_bloc (Cubit) | 9.1.1 |
| Backend | Firebase (`firebase_core` only); feature data comes from `data/mock/` | 4.11.0 |
| Local DB | None | - |
| Navigation | go_router (`StatefulShellRoute`, five tabs) | 17.5.0 |
| DI | get_it | 8.0.3 |
| Design system | `system_design` v5 generation ([flutter-system-design-kit](https://github.com/DAMHONGDUC/flutter-system-design-kit), git submodule) | pinned by commit |
| Tooling | [script-tools](https://github.com/DAMHONGDUC/script-tools) via `make` (git submodule) | pinned by commit |

## Project architecture

| | |
|---|---|
| Architecture | Feature-first Clean Architecture + Cubit |
| Encryption | None |

```mermaid
flowchart TD
  subgraph App["lib/src/app"]
    Router[AppRouter + AppShell] --> Global[Global Cubits: session, settings, cart, wishlist]
  end
  subgraph Feature["lib/src/features/order"]
    OrdersScreen --> OrdersController
    OrdersController --> GetOrdersUsecase
    GetOrdersUsecase --> OrderRepository
    OrderRepository -.implemented by.-> OrderRepositoryImpl
    OrderRepositoryImpl --> OrderRemoteDataSource
    OrderRemoteDataSource --> order_mock
  end
  Router --> OrdersScreen
  Global --> OtherUsecases[auth, settings, cart, wishlist usecases]
  Feature --> Core[lib/src/core: routes, l10n, shared widgets]
```

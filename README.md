# Tuku Shop

| | |
|---|---|
| Overview | Flutter e-commerce shopping app (*tuku* = "to buy" in Javanese), UI based on the [Kutuku Figma template](https://www.figma.com/design/MWXnUlavawxNQSMaYIsRRh/Kutuku----eCommerce-Mobile-App-UI-Kit-Figma-High-Quality-Template--Community-?node-id=0-1&p=f) |
| Last edit | 2026-09-29 |
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
| Framework | Flutter | 3.44.5 |
| Language | Dart | 3.12.2 |
| State management | flutter_bloc (Cubit) | 9.1.1 |
| Backend | None; feature data comes from `data/mock/` | - |
| Local DB | None | - |
| Special libraries | `system_design` v5 (in-house design system, `flutter-system-design-kit` git submodule) | pinned by commit |

## Project architecture

| | |
|---|---|
| Architecture | Feature-first Clean Architecture + Cubit |
| Encryption | None |

```mermaid
flowchart TD
  subgraph Presentation
    MyOrderScreen --> MyOrderController
  end
  subgraph Domain
    GetMyOrderUsecase --> OrderRepository
  end
  subgraph Data
    OrderRepositoryImpl --> OrderRemoteDataSource
    OrderRemoteDataSource --> order_mock
  end
  MyOrderController --> GetMyOrderUsecase
  OrderRepository -.implemented by.-> OrderRepositoryImpl
```

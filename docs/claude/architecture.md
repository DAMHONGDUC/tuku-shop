# Architecture rules

| Rule | Reason | Example |
|---|---|---|
| Each feature lives in `lib/src/features/<feature>/` with `domain/`, `data/`, `presentation/` | Feature-first Clean Architecture | `lib/src/features/order/` |
| `presentation → domain ← data`; `domain` never imports `data` | Swapping mock for a real API only touches `data/` | `domain/repositories/order_repository.dart` |
| New `domain/` code imports no Flutter (existing exceptions: `notification_category_entity.dart`, `setting_item_entity.dart`) | Domain stays pure Dart | `domain/entities/order_entity.dart` |
| Other features import only `domain/domain.dart` | Keeps features decoupled | `import '.../order/domain/domain.dart'` |
| Exception: `home/` is presentation-only and may import other features' section widgets and section controllers | It composes the Home tab from other features | `home_screen.dart` → `banner_carousel.dart` |
| App-wide code lives in `lib/src/app/`: `state/` (singleton Cubits: session, settings, cart, wishlist, unread notifications), `shell/` (tab bar), `app_router.dart` (the only importer of every `config/*_stack.dart`) | One owner for state every screen shares | `CartController` in `app_di.dart` |
| Route names/paths and route args live in `core/navigation/` (`AppRoutes`, `route_args.dart`); features navigate with `AppRoutes`, never another feature's `config/` | Features stay unaware of each other's screens | `context.push(AppRoutes.orders.path)` |
| A feature with no data of its own (e.g. `profile/`) has only `presentation/` and reads other features through their usecases | No empty layers | `ProfileController(getOrders:)` |
| Repository contract in `domain/repositories/`, impl in `data/repositories/<x>_repository_impl.dart` | One contract, swappable impl | `OrderRepositoryImpl` |
| Repositories and usecases return `Either<Failure, T>` (dartz) | Uniform error flow up to the Cubit | `lib/src/core/usecase/usecase.dart` |
| Usecases extend `UseCase<Type, Params>`, one per action, named `<Action>Usecase` | Single-purpose domain calls | `GetMyOrderUsecase` |
| Data sources return models; `data/mapper/` converts models → entities | Entities stay free of DTO shape | `order_model_to_order_entity_mapper.dart` |
| Mock data lives in `data/mock/` behind the data source | Stand-in for a real API | `data/mock/order_mock.dart` |
| Each feature registers its chain in `<feature>_di.dart` via `getIt`, called from `lib/src/di/injector.dart` | One DI entry per feature | `OrderDi.config()` |
| Data sources / repositories / usecases: `registerLazySingleton`; controllers: `registerFactory` | Fresh Cubit per screen | `order_di.dart` |
| Screen folder: `<screen>_screen.dart`, `<screen>_controller.dart`, `<screen>_state.dart`, `components/`, `config/` | Predictable screen layout | `presentation/my_order/` |
| Each feature lists its `GoRoute`s in `presentation/config/<feature>_stack.dart` (`tabRoutes` / `routes`) | `app_router.dart` assembles them | `ProfileStack.routes` |
| Cross-cutting code goes in `lib/src/core/` (constants, enums, l10n, navigation, resources, widgets) | No business logic in core | `lib/src/core/core.dart` |

## Never

| Don't | Instead |
|---|---|
| Import another feature's `data/`, or its `presentation/` outside `home/` | Use its `domain/domain.dart` barrel |
| Edit generated `app_localizations*.dart` | Edit `app_en.arb` / `app_vi.arb`, run `make gen` |
| Change code inside `packages/system_design_flutter` from this repo | It is a submodule with its own repo; bump the pointer instead |
| Hardcode app ids or the app name | Ids: see README "App IDs"; name: `AppConstants.appName` / `app_name` in ARB |

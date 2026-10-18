# Architecture rules

| Rule | Reason | Example |
|---|---|---|
| Each feature lives in `lib/src/features/<feature>/` with `domain/`, `data/`, `presentation/` | Feature-first Clean Architecture | `lib/src/features/order/` |
| `presentation → domain ← data`; `domain` never imports `data` | Swapping mock for a real API only touches `data/` | `domain/repositories/order_repository.dart` |
| New `domain/` code imports no Flutter (existing exceptions: `notification_category_entity.dart`, `setting_item_entity.dart`) | Domain stays pure Dart | `domain/entities/order_entity.dart` |
| Other features import only `domain/domain.dart` | Keeps features decoupled | `import '.../order/domain/domain.dart'` |
| Exception: `home/` and `bottom_tab/` are presentation-only and may import other features' section widgets, section controllers and `config/*_stack.dart` | They compose screens from other features | `home_screen.dart` → `banner_carousel_section.dart` |
| Repository contract in `domain/repositories/`, impl in `data/repositories/<x>_repository_impl.dart` | One contract, swappable impl | `OrderRepositoryImpl` |
| Repositories and usecases return `Either<Failure, T>` (dartz) | Uniform error flow up to the Cubit | `lib/src/core/usecase/usecase.dart` |
| Usecases extend `UseCase<Type, Params>`, one per action, named `<Action>Usecase` | Single-purpose domain calls | `GetMyOrderUsecase` |
| Data sources return models; `data/mapper/` converts models → entities | Entities stay free of DTO shape | `order_model_to_order_entity_mapper.dart` |
| Mock data lives in `data/mock/` behind the data source; every data source call starts with `await MockLatency.wait()` (1 s) and nothing else delays | Stand-in for a real API with one latency knob | `data/mock/order_mock.dart` |
| Each feature registers its chain in `<feature>_di.dart` via `getIt`, called from `lib/src/di/injector.dart` | One DI entry per feature | `OrderDi.config()` |
| Data sources / repositories / usecases: `registerLazySingleton`; controllers: `registerFactory` | Fresh Cubit per screen | `order_di.dart` |
| Screen folder: `<screen>_screen.dart`, `<screen>_controller.dart`, `<screen>_state.dart`, `components/`, `config/` | Predictable screen layout | `presentation/my_order/` |
| Routes are `SdRouterV5` constants in `lib/src/core/navigation/routes/<screen>_routes.dart`; the screen's `config/<screen>_stack.dart` builds the `GoRoute` | Any feature can navigate without importing another feature's `presentation/` | `MyOrderRoutes.myOrder` |
| Cross-cutting code goes in `lib/src/core/` (constants, enums, l10n, navigation, resources, widgets) | No business logic in core | `lib/src/core/core.dart` |

## Never

| Don't | Instead |
|---|---|
| Import another feature's `data/`, or its `presentation/` outside `home/` / `bottom_tab/` | Use its `domain/domain.dart` barrel |
| Edit generated `app_localizations*.dart` | Edit `app_en.arb` / `app_vi.arb`, run `fvm dart run melos run gen:l10n` |
| Change code inside `packages/flutter-system-design-kit` from this repo | It is a submodule with its own repo; bump the pointer instead |
| Hardcode app ids or the app name | Ids: see README "App IDs"; name: `AppConstants.appName` / `app_name` in ARB |

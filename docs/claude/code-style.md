# Code style rules

| Rule | Reason | Example |
|---|---|---|
| Controllers are Cubits named `<Screen>Controller`; state is a `part` file `<screen>_state.dart` | Existing pattern in every screen | `my_order_controller.dart` + `part 'my_order_state.dart'` |
| States extend `Equatable` | Correct `bloc_test` comparisons and rebuilds | `MyOrderState` |
| Spacing uses `SdSpacingV5` / `SdVerticalSpacingV5` / `SdHorizontalSpacingV5` | Design-system spacing ladder (kit generation v5) | `SdSpacingV5.s16` |
| Text styles use `SdTextStyleV5`; icons use `SdIconV5` | Consistent typography and icon sizing | `SdTextStyleV5` |
| User-facing strings go through ARB files, read with `context.loc` | Supports `en` and `vi` | `context.loc.app_name` |
| Imports use the package form `package:tuku_shop/...` | Matches the whole codebase | `import 'package:tuku_shop/src/core/core.dart';` |
| File names are snake_case of the class | Findable by class name | `OrderRepositoryImpl` → `order_repository_impl.dart` |

## Never

| Don't | Instead |
|---|---|
| Put business logic in widgets | Move it to the Cubit or a usecase |
| Call a data source or repository from a Cubit | Call a usecase |
| Use a V2 / V3 / V4 design-kit widget, token or helper | Use V5; if V5 lacks it, clone it into `lib/src/core/widgets/` from V5 tokens |

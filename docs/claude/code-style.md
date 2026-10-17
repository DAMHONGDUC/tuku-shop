# Code style rules

| Rule | Reason | Example |
|---|---|---|
| Controllers are Cubits named `<Screen>Controller`; state is a `part` file `<screen>_state.dart` | Existing pattern in every screen | `my_order_controller.dart` + `part 'my_order_state.dart'` |
| States extend `Equatable` | Correct `bloc_test` comparisons and rebuilds | `MyOrderState` |
| Spacing uses `SdSpacingConstant` (`w*`, `h*`, `r*`) and `SdContentPaddingV5`; widgets come from the kit's v5 generation (`Sd*V5`) | Design-system spacing ladder, screen-scaled | `SizedBox(height: SdSpacingConstant.h16)` |
| Text styles come from `context.textTheme5` plus `SdTextStyleV5X` helpers; icons use `SdIconV5` with `Symbols.*` | Consistent typography and icon sizing | `context.textTheme5.bodyMedium!.muted5(context)` |
| User-facing strings go through ARB files, read with `context.loc` | Supports `en` and `vi` | `context.loc.app_name` |
| Imports use the package form `package:tuku_shop/...` | Matches the whole codebase | `import 'package:tuku_shop/src/core/core.dart';` |
| File names are snake_case of the class | Findable by class name | `OrderRepositoryImpl` → `order_repository_impl.dart` |

## Never

| Don't | Instead |
|---|---|
| Put business logic in widgets | Move it to the Cubit or a usecase |
| Call a data source or repository from a Cubit | Call a usecase |

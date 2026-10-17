# Testing

Tests mirror [lib/src/](../lib/src/) under [test/](../test/): `test/features/` and `test/app/`.

| Target | Tooling |
|---|---|
| Repository impls and mock data sources | `flutter_test`, real in-memory data with `MockLatency.enabled = false` |
| Domain entities (cart totals) | `flutter_test` |
| Cubits (loading / loaded / error sequences) | `bloc_test` |
| Shared mocks and fixtures | [test/helpers/](../test/helpers/) |
| App smoke test | [test/widget_test.dart](../test/widget_test.dart) |

```bash
make test
make test TEST=test/features/cart
```

# Testing rules

| Rule | Reason | Example |
|---|---|---|
| Tests mirror `lib/src/features/` under `test/features/` | Test found from source path | `test/features/order/...` |
| Cover usecases, repository impls, data sources and Cubits | Where logic lives | `order_repository_impl_test.dart` |
| Cubits are tested with `bloc_test` state sequences | Checks loading / loaded / error order | `my_order_detail_controller_test.dart` |
| Mocks use `mocktail`; shared mocks live in `test/helpers/` | No codegen, no duplicate mocks | `test/helpers/mock_usecases.dart` |
| Verify a change with the single affected test file | Faster than the full suite | `make test TEST=test/features/order/<path>_test.dart` |
| `make analyze` must report no issues (it runs with `--fatal-infos`) | CI runs the same script | `.github/workflows/ci.yml` |

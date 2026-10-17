# CLAUDE.md

| | |
|---|---|
| Project | Tuku Shop: Flutter e-commerce app, Cubit + Clean Architecture, design system and scripts as submodules |
| Entry point | `lib/main.dart` |
| Package | `tuku_shop` (imports: `package:tuku_shop/...`) |

## Commands

| Task | Command |
|---|---|
| List every command | `make` |
| Setup (after clone / pull) | `make set-up` |
| Run | `make run` |
| Test single file | `make test TEST=test/features/<feature>/<path>_test.dart` |
| Test the app | `make test` |
| Analyze (CI gate, infos fail too) | `make analyze` |
| Format | `make format` |
| Codegen (l10n) | `make gen` |

## Rules

- @docs/claude/architecture.md
- @docs/claude/code-style.md
- @docs/claude/testing.md
- @docs/claude/docs.md

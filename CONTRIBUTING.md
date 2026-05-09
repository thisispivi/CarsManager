# Contributing to CarsManager

Thank you for helping make CarsManager better. This guide covers everything you need to contribute effectively.

---

## Table of Contents

1. [Development environment](#development-environment)
2. [Branch strategy](#branch-strategy)
3. [Commit conventions](#commit-conventions)
4. [Pull request process](#pull-request-process)
5. [Code style](#code-style)
6. [Testing requirements](#testing-requirements)

---

## Development environment

See [ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md) for a step-by-step guide to get your local environment running.

Short version:

```bash
git clone https://github.com/apirasp/CarsManager.git
cd CarsManager

# Install Node.js tooling (commit linting, husky)
npm install

# Install Flutter dependencies
cd cars_manager
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## Branch strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production-ready code. Only tagged releases merge here. |
| `develop` | Integration branch. All feature PRs target this branch. |
| `feature/<name>` | New features or improvements. Branch from `develop`. |
| `fix/<name>` | Bug fixes. Branch from `develop` (or `main` for hotfixes). |
| `hotfix/<name>` | Critical production fixes. Branch from `main`, PR to both `main` and `develop`. |
| `docs/<name>` | Documentation-only changes. |
| `ci/<name>` | CI/CD workflow changes. |

```
main ←── hotfix/*
  ↑
develop ←── feature/* ←── fix/* ←── docs/*
```

---

## Commit conventions

This project enforces [Conventional Commits](https://www.conventionalcommits.org/). The `commit-msg` Git hook will reject non-conforming messages.

### Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

### Types

| Type | When to use |
|------|------------|
| `feat` | New user-visible feature |
| `fix` | Bug fix |
| `perf` | Performance improvement |
| `refactor` | Code change with no functional impact |
| `style` | Formatting, whitespace, no logic change |
| `test` | Adding or updating tests |
| `docs` | Documentation only |
| `ci` | CI/CD workflow changes |
| `build` | Build system or dependency changes |
| `chore` | Maintenance (tooling, configs) |
| `revert` | Reverts a previous commit |

### Examples

```
feat(garage): add hero animation on car tile tap
fix(fuel): fix negative consumption when liters is zero
perf(charts): wrap fl_chart in RepaintBoundary to reduce repaints
docs: update ENVIRONMENT_SETUP with Windows instructions
ci: add Codecov upload step to test job
chore(deps): bump flutter_riverpod to 2.6.1
```

### Breaking changes

Add `!` after the type or add `BREAKING CHANGE:` in the footer:

```
feat(storage)!: migrate to encrypted local database

BREAKING CHANGE: existing JSON data files are not compatible.
Run the migration script before updating.
```

---

## Pull request process

1. **Fork** the repo and create your branch from `develop`.
2. **Make your changes** following the code style guide below.
3. **Write or update tests** — PRs without test coverage for new logic will be asked to add it.
4. **Run locally before opening a PR:**
   ```bash
   cd cars_manager
   dart format .
   flutter analyze
   flutter test
   ```
5. **Open a PR** against `develop` using the PR template.
6. **Address review feedback** — all comments should be resolved or responded to.
7. **Squash and merge** — the PR is squash-merged with a conventional commit message.

---

## Code style

- **Formatting:** `dart format` (enforced by pre-commit hook and CI)
- **Analysis:** `flutter analyze --fatal-infos` (enforced by CI)
- **Single quotes:** always use `'single'` not `"double"` for Dart strings
- **Trailing commas:** required in multi-line argument lists and widget trees
- **Const:** use `const` constructors and `const` widget creation wherever possible
- **No `print`:** use structured logging or remove debug prints before committing
- **Imports:** use package imports (`import 'package:cars_manager/...'`), not relative imports
- **Comments:** write comments only when the *why* is non-obvious — not what the code does

---

## Testing requirements

| Test type | Where | Requirement |
|-----------|-------|------------|
| Unit tests | `test/unit/` | Required for all business logic, notifiers, repositories |
| Widget tests | `test/widget/` | Required for shared components and screen smoke tests |
| Integration tests | `integration_test/` | Key user flows (add car, add fuel entry) |

Run all tests:

```bash
cd cars_manager
flutter test --coverage
```

Target coverage: **> 60%** for `lib/` (checked by Codecov on every PR).

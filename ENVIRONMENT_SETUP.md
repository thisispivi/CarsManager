# Environment Setup

This guide covers everything you need to run and develop CarsManager locally.

---

## Prerequisites

### 1. Flutter SDK

Install the **stable** channel:

```bash
# macOS / Linux (via FVM — recommended)
dart pub global activate fvm
fvm install stable
fvm use stable

# Or via official installer: https://docs.flutter.dev/get-started/install
```

Verify:

```bash
flutter doctor
```

All items should be green (except iOS if you're on Linux/Windows — that's fine).

### 2. Android SDK

- Install [Android Studio](https://developer.android.com/studio)
- Open SDK Manager → install:
  - Android SDK Platform (API 35)
  - Android SDK Build-Tools
  - Android Emulator
  - Google USB Driver (Windows only)
- Accept licences: `flutter doctor --android-licenses`

### 3. Node.js (for commit tooling)

Required for `commitlint` and `husky`:

```bash
# macOS
brew install node

# Windows
winget install OpenJS.NodeJS.LTS

# Linux
curl -fsSL https://fnm.vercel.app/install | bash
fnm use --install-if-missing 22
```

---

## Clone and install

```bash
git clone https://github.com/apirasp/CarsManager.git
cd CarsManager

# Install Node.js tooling (commit linting, husky hooks)
npm install

# Install Flutter dependencies
cd cars_manager
flutter pub get

# Generate code (Riverpod providers + Freezed models)
dart run build_runner build --delete-conflicting-outputs
```

---

## Run the app

### Android

1. Start an emulator from Android Studio, or connect a physical device with USB debugging enabled.
2. Run:

```bash
cd cars_manager
flutter run
```

### Web (Chrome)

```bash
cd cars_manager
flutter run -d chrome
```

### Web (any browser via local server)

```bash
cd cars_manager
flutter build web --release
# Serve with any static file server, e.g.:
npx serve build/web
```

---

## IDE setup

### VS Code (recommended)

Install extensions:

- **Flutter** (`dart-code.flutter`)
- **Dart** (`dart-code.dart-code`)
- **Riverpod Snippets** (`robert-brunhage.flutter-riverpod-snippets`)
- **Error Lens** (`usernamehw.errorlens`)

The `.vscode/launch.json` in the repository provides three run configurations:

- `Cars Manager` — debug mode
- `Cars Manager (profile mode)` — for performance profiling
- `Cars Manager (release mode)` — as close to production as possible

### Android Studio / IntelliJ

Install the **Flutter** plugin. Open the `cars_manager/` directory as the project root.

---

## Code generation

CarsManager uses `build_runner` for Riverpod and Freezed code generation.

After modifying any file annotated with `@riverpod`, `@freezed`, or `@JsonSerializable`:

```bash
cd cars_manager
dart run build_runner build --delete-conflicting-outputs
```

For watch mode during active development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## Running tests

```bash
cd cars_manager

# All tests
flutter test

# With coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html   # macOS
```

---

## Pre-commit hooks

Husky hooks run automatically on `git commit`:

| Hook | What it does |
|------|-------------|
| `commit-msg` | Validates commit message against conventional commits format |
| `pre-commit` | Runs `lint-staged` (format + analyze) then `flutter test` |

If a hook fails, fix the issue and re-run `git commit`.

---

## Localization

The app supports English (`en`) and Italian (`it`). String files are in `cars_manager/lib/l10n/`.

After editing `.arb` files, regenerate the localization classes:

```bash
cd cars_manager
flutter gen-l10n
```

Or run any `flutter` command with `--no-pub` — generation happens automatically because `generate: true` is set in `pubspec.yaml`.

---

## Troubleshooting

**`build_runner` fails with conflicts:**

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

**`flutter pub get` fails:**

Ensure you're using Dart SDK `^3.8.0`. Check with `dart --version`.

**Android build fails with Gradle errors:**

```bash
cd cars_manager/android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

**Husky hooks not running:**

```bash
# From repo root
npm install
npx husky
```

<div align="center">
  <img src="cars_manager/assets/icons/CarsManagerLogoFull.png" alt="CarsManager" height="80" />
  <h3>CarsManager</h3>
  <p>The smart way to manage your vehicles.</p>

  [![CI](https://github.com/apirasp/CarsManager/actions/workflows/ci.yml/badge.svg)](https://github.com/apirasp/CarsManager/actions/workflows/ci.yml)
  [![Release](https://img.shields.io/github/v/release/apirasp/CarsManager?include_prereleases&label=release)](https://github.com/apirasp/CarsManager/releases)
  [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
  [![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter)](https://flutter.dev)
  [![Platform](https://img.shields.io/badge/platform-Android%20%7C%20Web-brightgreen)](https://github.com/apirasp/CarsManager)
</div>

---

## Overview

CarsManager is a privacy-first vehicle management app built with Flutter. It stores data locally, with no account, cloud sync, or subscription required.

Use it to manage multiple vehicles, track fuel entries, record insurance, inspections, taxes, repairs, and fines, and keep an eye on due dates and yearly cost trends.

---

## Features

| Category | Details |
|----------|---------|
| Garage | Add multiple vehicles with photos, model details, fuel type, and license plate |
| Fuel | Log fill-ups with amount, total cost, unit price, and yearly charts |
| Payments | Track insurance, inspections, road tax, repairs, and traffic fines |
| Reminders | Store upcoming due dates and notification preferences locally |
| Analytics | Review yearly totals, category distribution, and fuel trends |
| Localization | English and Italian |
| Themes | Light and dark mode |
| Web | Runs as a browser app/PWA |

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter stable |
| Language | Dart 3.x |
| State management | Flutter Riverpod 2.x with generated `@riverpod` feature providers |
| Navigation | GoRouter with URL-backed tab routes |
| Storage | Local JSON file on native platforms, `localStorage` on web |
| Code generation | build_runner, Freezed, json_serializable |
| Charts | fl_chart |
| Typography | Google Fonts |
| Notifications | flutter_local_notifications |
| CI/CD | GitHub Actions |
| Repository tooling | Husky, lint-staged, commitlint |

---

## Quick Start

```bash
git clone https://github.com/apirasp/CarsManager.git
cd CarsManager

npm install

cd cars_manager
flutter pub get
flutter run
```

For web:

```bash
flutter run -d chrome
```

See [ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md) for full setup and troubleshooting.

---

## Architecture

```text
cars_manager/lib/
├── app/                  # App root, GoRouter config, Riverpod app state
├── core/                 # Theme tokens, app services, storage adapters
├── data/                 # Seed data and persistence helpers
├── features/             # Feature modules such as analytics
├── l10n/                 # ARB files and generated localization classes
├── models/               # Vehicle, fuel, payment, and settings models
├── presentation/
│   ├── common/           # Shared widgets, extensions, and UI utilities
│   ├── pages/            # Home, car form, fuel, and payments screens
│   └── widgets/          # Cross-page app widgets
└── main.dart             # App bootstrap and CarsManagerState
```

The app now boots through `ProviderScope` and `MaterialApp.router`. Feature domains expose generated Riverpod providers while existing screens are migrated feature by feature. Storage is abstracted behind conditional imports so native builds use a JSON file and web builds use browser storage.

See [ARCHITECTURE.md](ARCHITECTURE.md) for more detail.

---

## CI/CD

| Workflow | Trigger | Jobs |
|----------|---------|------|
| `ci.yml` | Push/PR to `main` and `develop` | Format, analyze, test, Android build, web build |
| `release.yml` | Version tag push | Test, build APKs, build web, create GitHub Release |
| `deploy-web.yml` | Successful release workflow | Publish the web artifact to GitHub Pages |

---

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a PR. The short version:

- Use conventional commits, enforced by commitlint.
- Run `npm run verify` from the repository root before pushing.
- Run `cd cars_manager && dart run build_runner build --delete-conflicting-outputs` after changing generated models.
- Keep Flutter changes formatted with `dart format`.
- Keep docs and release notes aligned with user-facing changes.

---

## Project Docs

- [Architecture](ARCHITECTURE.md)
- [Design System](DESIGN_SYSTEM.md)
- [Environment Setup](ENVIRONMENT_SETUP.md)
- [Release Process](RELEASE.md)
- [Roadmap](ROADMAP.md)
- [Security](SECURITY.md)

---

## License

[MIT](LICENSE) - Copyright (c) 2025 Andrea Piras

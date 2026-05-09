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

CarsManager is a modern, privacy-first vehicle management app built with Flutter. All data is stored locally on your device — no accounts, no cloud, no subscriptions.

Track everything about your vehicles in one place: fuel consumption, maintenance history, insurance, taxes, repairs, traffic fines, and upcoming reminders. Beautiful charts and analytics give you a clear picture of your vehicle costs over time.

---

## Features

| Category | Details |
|----------|---------|
| **Garage** | Add multiple vehicles with photos, model details, fuel type, and license plate |
| **Fuel Tracking** | Log fill-ups with liters, total cost, and price per liter — see consumption trends |
| **Expenses** | Track insurance, inspections (MOT), road tax, repairs, and traffic fines |
| **Reminders** | Get notified before insurance, inspection, and tax due dates |
| **Analytics** | Yearly cost breakdowns, category distribution, fuel efficiency charts |
| **Multi-vehicle** | Switch between vehicles instantly — all data is per-vehicle |
| **Themes** | Full dark and light mode support |
| **Localization** | English and Italian (easily extensible) |
| **Web support** | Works as a PWA in any modern browser |

---

## Screenshots

> _Screenshots coming with the v1.1 UI overhaul._

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (stable) |
| Language | Dart 3.x |
| State management | Riverpod 2.x (`@riverpod` code-gen) |
| Navigation | GoRouter |
| Data models | Freezed + json_serializable |
| Storage | Local JSON file (mobile) / localStorage (web) |
| Charts | fl_chart |
| Typography | Google Fonts — Space Grotesk |
| Notifications | flutter_local_notifications |
| CI/CD | GitHub Actions |

---

## Getting Started

### Prerequisites

- Flutter SDK (stable channel): [install guide](https://docs.flutter.dev/get-started/install)
- Android SDK (for Android builds)
- A browser (for web)

See [ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md) for a full setup guide.

### Quick start

```bash
# Clone the repository
git clone https://github.com/apirasp/CarsManager.git
cd CarsManager/cars_manager

# Install dependencies
flutter pub get

# Generate code (Riverpod + Freezed)
dart run build_runner build --delete-conflicting-outputs

# Run on Android
flutter run

# Run on web
flutter run -d chrome
```

---

## Architecture Overview

```
cars_manager/lib/
├── app/              # Root widget, GoRouter config
├── core/             # Services, theme, storage, utilities
├── features/         # Feature modules (garage, fuel, expenses, analytics, settings)
│   └── <feature>/
│       ├── data/     # Models, repositories
│       ├── domain/   # Riverpod notifiers
│       └── presentation/ # Screens, widgets
├── shared/           # Shared widgets, utils
└── l10n/             # Localization (EN, IT)
```

See [ARCHITECTURE.md](ARCHITECTURE.md) for the full design document.

---

## CI/CD

| Workflow | Trigger | Jobs |
|----------|---------|------|
| `ci.yml` | Push/PR to `main`, `develop` | Analyze → Test → Build Android + Web |
| `release.yml` | Push tag `v*.*.*` | Build → Create GitHub Release with APK |
| `deploy-web.yml` | After release | Deploy web build to GitHub Pages |

---

## Contributing

We welcome contributions! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for:

- Branch and commit conventions
- Development workflow
- PR process
- Code style guide

---

## Release

See [RELEASE.md](RELEASE.md) for how to cut a stable or beta release.

All releases follow [Semantic Versioning](https://semver.org). See [CHANGELOG.md](CHANGELOG.md) for the full history.

---

## Roadmap

See [ROADMAP.md](ROADMAP.md) for planned features and milestones.

---

## License

[MIT](LICENSE) — © 2025 Andrea Piras

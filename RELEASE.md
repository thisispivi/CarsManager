# Release Process

This document describes how to cut a CarsManager release.

---

## Release types

| Type | Version format | Example | Branch |
|------|---------------|---------|--------|
| Stable | `v<major>.<minor>.<patch>` | `v1.2.0` | `main` |
| Beta | `v<major>.<minor>.<patch>-beta.<n>` | `v1.2.0-beta.1` | `main` |

---

## Prerequisites

- You have merged all intended changes into `main`.
- `flutter test` passes locally.
- `CHANGELOG.md` is updated with entries for this release.

---

## Steps

### 1. Update version in pubspec.yaml

Edit `cars_manager/pubspec.yaml`:

```yaml
version: 1.2.0+<build_number>
```

`versionName` = `1.2.0`, `versionCode` = `<build_number>` (use a timestamp or incrementing integer).

### 2. Update CHANGELOG.md

Move items from `[Unreleased]` to a new section:

```markdown
## [1.2.0] — 2025-06-15

### Added
- ...

### Changed
- ...

### Fixed
- ...
```

Update the diff links at the bottom:

```markdown
[1.2.0]: https://github.com/apirasp/CarsManager/compare/v1.1.0...v1.2.0
```

### 3. Commit and tag

```bash
git add cars_manager/pubspec.yaml CHANGELOG.md
git commit -m "chore(release): v1.2.0"
git tag v1.2.0
git push origin main --tags
```

### 4. CI takes over

Pushing the tag `v1.2.0` triggers `.github/workflows/release.yml`, which:

1. Runs `flutter test`
2. Builds `app-arm64-v8a-release.apk`, `app-armeabi-v7a-release.apk`, `app-x86_64-release.apk`
3. Builds the web release
4. Creates a GitHub Release with:
   - Auto-generated release notes from conventional commits
   - APK files as release assets
5. Triggers `.github/workflows/deploy-web.yml` → deploys web to GitHub Pages

### 5. Verify

- Check the [Actions tab](https://github.com/apirasp/CarsManager/actions) — all jobs green.
- Check the [Releases page](https://github.com/apirasp/CarsManager/releases) — APKs attached, notes correct.
- Check [GitHub Pages](https://apirasp.github.io/CarsManager/) — web version updated.

---

## Beta release

Same process, just use `v1.2.0-beta.1` as the tag. The release workflow marks it as a pre-release automatically.

---

## Hotfix release

1. Branch from `main`: `git checkout -b hotfix/fix-critical-crash main`
2. Apply fix, commit normally
3. Bump patch version (`v1.1.1`), update changelog
4. PR → `main` (fast-track review)
5. Merge, tag `v1.1.1`, push
6. Back-merge `main` → `develop`: `git checkout develop && git merge main`

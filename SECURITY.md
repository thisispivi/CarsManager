# Security Policy

## Supported versions

| Version | Supported |
|---------|-----------|
| Latest stable | ✅ |
| Beta releases | ⚠️ Best-effort |
| Older releases | ❌ |

## Reporting a vulnerability

**Please do not open a public GitHub issue for security vulnerabilities.**

To report a security issue, email: **security@carsmanager.io** (or open a [private vulnerability report](https://github.com/apirasp/CarsManager/security/advisories/new) on GitHub).

Include in your report:

1. A description of the vulnerability and its potential impact
2. Steps to reproduce
3. Affected version(s)
4. Any suggested mitigation (optional)

### What to expect

- **Acknowledgement** within 48 hours
- **Assessment** within 7 days
- **Fix timeline** communicated once assessed
- **Credit** in the release notes (if desired)

## Security model

CarsManager is a local-first app. All data is stored on-device:

- **No server** — no user data is transmitted to external servers
- **No analytics** — no telemetry or usage tracking
- **No accounts** — no login, no credentials stored
- **Local storage** — data is in a plain JSON file on Android/iOS, and in `localStorage` on web

The primary security consideration is protecting the local data file from other apps or processes on the device. CarsManager relies on the OS-level app sandboxing for this protection.

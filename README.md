# 🔐 KFHGitHubApp

An iOS SwiftUI GitHub client demonstrating OAuth login, secure token storage, fetching authenticated user repos, and clean modular architecture.

---

## 🚀 Features

- 🔐 GitHub OAuth login via Safari
- 🔒 Token saved securely in Keychain
- 📂 Fetch and display user's repositories
- 🔍 Search/filter repos by name
- 🔁 Pull to refresh
- 🌱 View branches of a selected repo
- ✅ Unit and UI tests included
- 📱 Works on iOS 16+

---

## 🧱 Architecture Overview

Follows **Clean Architecture** + **MVVM** structure:

```
Features/
├── Auth/
├── RepositoryList/
├── BranchList/
Core/
├── Networking/
├── Models/
├── Configuration/
```

- **Presentation Layer**: SwiftUI views, ViewModels (observable)
- **Domain Layer**: UseCases + Repository protocols
- **Data Layer**: API implementations
- **Core**: Shared logic (Keychain, API config, Secrets)

Uses:
- `async/await` for networking
- `Combine` for reactive view updates
- `@MainActor` safe ViewModel mutation
- `@testable` unit tests
- `.xcconfig` for secrets

---

## ⚙️ Setup Instructions

### 1. Clone

```bash
git clone https://github.com/your-username/KFHGitHubApp.git
```

### 2. GitHub OAuth Setup

Register a GitHub OAuth App:

- **Client ID** + **Client Secret**
- **Callback URL**: `kfhgithubapp://callback`

### 3. Configure `.xcconfig`

`Debug.xcconfig`:

```xcconfig
GITHUB_CLIENT_ID=your_client_id
GITHUB_CLIENT_SECRET=your_client_secret
```

Update your `Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>kfhgithubapp</string>
    </array>
  </dict>
</array>
```

---

## 🧪 Tests

- `FetchRepositoriesUseCaseTests.swift`
- `RepoListViewModelTests.swift`
- ✅ Login + navigation tested with UITests

To run UI tests:

- Go to **Edit Scheme → KFHGitHubAppUITests → Arguments → Environment Variables**:
  - Add `UITEST_MODE = YES`
- Run `Cmd + U`

---

## 🔄 Trade-offs & Constraints

| Topic               | Decision                                                                 |
|--------------------|--------------------------------------------------------------------------|
| Auth Web Flow      | Used native Safari for simplicity (not `ASWebAuthenticationSession`)     |
| Secrets handling   | `.xcconfig` for injection; not using Apple Secrets Vault                 |
| Token Storage      | `KeychainHelper` via `UserDefaults` fallback (no secure enclave used)    |
| Deep Linking       | Configured, but not handled (placeholder only)                           |
| Dependency Injection | Not using external DI library (manual injection)                     |

---

## 🔮 Future Work

- [ ] Handle token expiration + refresh flow
- [ ] Add repository language chips
- [ ] Add branch protection status UI
- [ ] Add deep linking for repo/branch views
- [ ] Use `AppIntent` or `Shortcuts` for SSO

---

## 👨‍💻 Author

Haitham Gado  
GitHub: [@gadolizm](https://github.com/gadolizm)

---

© 2025 - For KFH GitHub OAuth task

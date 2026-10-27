# stellar-dev-containers

[![CI](https://github.com/CloudNativeIlorin/stellar-dev-containers/actions/workflows/ci.yml/badge.svg)](https://github.com/CloudNativeIlorin/stellar-dev-containers/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Stellar CLI](https://img.shields.io/badge/Stellar-CLI-08B5E5.svg)](https://stellar.org)
[![Soroban](https://img.shields.io/badge/Soroban-WASM-7B1FA2.svg)](https://soroban.stellar.org)
[![Cloud Native Ilorin](https://img.shields.io/badge/Maintained%20by-Cloud%20Native%20Ilorin-blue.svg)](https://github.com/CloudNativeIlorin)

> **Maintained by Cloud Native Ilorin**  
> Bridging Cloud-Native developer tooling with the Stellar & Soroban smart contract ecosystem.

---

## 🌟 Mission Statement

**`stellar-dev-containers`** provides standardized, reproducible, and portable container environments for developers building, compiling, and testing Stellar and Soroban smart contracts.

By abstracting away local toolchain discrepancies (Rust versions, WebAssembly targets, OS-specific build dependencies, and CLI versions), this project eliminates the classic *"works on my machine"* problem and enables instant onboarding for developers across Linux, macOS, and Windows.

---

## 🚀 Key Features

- **Lightweight Multi-Stage Base**: Built on Debian slim (`rust:slim`) to balance minimal image footprints with developer ergonomics.
- **Pre-Configured Soroban WASM Target**: Comes out-of-the-box with `wasm32v1-none` configured for modern Soroban smart contract compilation.
- **Latest Stellar CLI**: Ships with the official, optimized `stellar-cli` binary pre-compiled and placed in the system PATH.
- **Docker Compose Orchestration**: Ready-to-use `docker-compose.yml` for interactive contract builds with persistent cargo caching.
- **One-Click Dev Containers & Codespaces**: Pre-configured `.devcontainer/devcontainer.json` with Rust Analyzer, Clippy, Even Better TOML, Crates, and CodeLLDB preloaded.
- **Local RPC Ready**: Includes scaffolding for running a local Stellar testnet or standalone node via `stellar/quickstart`.
- **Prepared for Drips Stellar Wave**: Seeded with beginner, intermediate, and advanced issues for open-source contributors.

---

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed on your host system:
- [Docker Engine](https://docs.docker.com/engine/install/) (v20.10 or later)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.0 or later) or Docker Desktop

---

## ⚡ Quickstart

### 1. Clone the Repository

```bash
git clone https://github.com/CloudNativeIlorin/stellar-dev-containers.git
cd stellar-dev-containers
```

### 2. Build the Container Image

Using Docker Compose:
```bash
docker compose build
```

Or using standard Docker CLI:
```bash
docker build -t stellar-dev-container .
```

### 3. Verify the Installation

Confirm that `stellar-cli` is properly configured inside the container:

```bash
# Using Docker Compose
docker compose run --rm soroban-builder stellar --version

# Using Docker CLI directly
docker run --rm stellar-dev-container stellar --version
```

Output should display the active Stellar CLI version (e.g., `stellar 22.x.x`).

---

## 💻 Developer Workflow

### Interactive Shell

To drop into an interactive shell inside the container with your current workspace mounted:

```bash
docker compose run --rm --entrypoint /bin/bash soroban-builder
```

### Building a Soroban Smart Contract

Place or generate your Soroban project in the repository root (or mount your contract directory):

```bash
# Inside the container or via compose run:
docker compose run --rm soroban-builder cargo build --target wasm32v1-none --release
```

The resulting `.wasm` binary will be available in `./target/wasm32v1-none/release/`.

---

## 💻 Develop with Dev Containers / Codespaces

This repository ships with a full [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) configuration for **Visual Studio Code (Dev Containers)** and **GitHub Codespaces**.

### Option 1: Launch in GitHub Codespaces

1. Navigate to the repository on GitHub and click the **Code** button.
2. Switch to the **Codespaces** tab and click **Create codespace on main**.
3. Codespaces will build the container, mount `/workspace`, install the preloaded Rust/Soroban extensions, forward port `8000`, and run the `postCreateCommand` verification hook.

### Option 2: Open in VS Code Dev Containers

1. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) in Visual Studio Code.
2. Clone and open the repository:
   ```bash
   git clone https://github.com/CloudNativeIlorin/stellar-dev-containers.git
   code stellar-dev-containers
   ```
3. Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run **Dev Containers: Reopen in Container**.
4. Once built, the integrated terminal opens directly in `/workspace` with `stellar`, `cargo`, and the `wasm32v1-none` target ready on `PATH`.

### Preloaded Extensions & Settings

- `rust-lang.rust-analyzer` (configured with `"rust-analyzer.check.command": "clippy"`)
- `tamasfe.even-better-toml` (TOML syntax & `Cargo.toml` schema support)
- `serayuzgur.crates` (Cargo dependency version management)
- `vadimcn.vscode-lldb` (LLDB native debugger)
- `"editor.formatOnSave": true` and automatic port forwarding for port `8000` (Stellar RPC / Horizon)

---

## 🌊 Drips Stellar Wave Program

This repository is submitted to the **Drips Stellar Wave Program** to foster open-source contributions across Africa and the global developer ecosystem.

Community contributors can pick up scoped issues, submit pull requests, and earn points/rewards. Issues are categorized by complexity:

| Tier | Points | Focus Areas |
| :--- | :--- | :--- |
| **Trivial** | `100 Pts` | Developer scripting, documentation improvements, linter integrations |
| **Medium** | `150 Pts` | Local RPC integration (`stellar/quickstart`), CI multi-arch publishing (GHCR) |
| **High** | `200 Pts` | Full `.devcontainer` configuration, VS Code / Codespaces pre-wiring |

Check the repository [Issues](https://github.com/CloudNativeIlorin/stellar-dev-containers/issues) tab to get started.

---

## 🤝 Contributing

We welcome contributions from developers of all skill levels! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for branch naming conventions, commit guidelines, and pull request requirements.

All pull requests must pass the CI pipeline (Dockerfile linting and container test build) before they can be merged.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
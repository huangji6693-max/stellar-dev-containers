# =========================================================================
# stellar-dev-containers
# Maintained by Cloud Native Ilorin
# Multi-stage lightweight toolchain for Stellar & Soroban smart contracts
# =========================================================================

# -------------------------------------------------------------------------
# Stage 1: Builder - Build & install stellar-cli
# -------------------------------------------------------------------------
FROM rust:slim AS builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    pkg-config \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install the official Stellar CLI (locked version; optimization enabled by default in stellar-cli >= 22)
RUN cargo install --locked stellar-cli

# -------------------------------------------------------------------------
# Stage 2: Runtime & Development Environment
# -------------------------------------------------------------------------
FROM rust:slim

LABEL maintainer="Cloud Native Ilorin <community@cloudnativeilorin.org>"
LABEL org.opencontainers.image.title="stellar-dev-containers"
LABEL org.opencontainers.image.description="Standardized, lightweight container environment for Stellar and Soroban development"
LABEL org.opencontainers.image.source="https://github.com/CloudNativeIlorin/stellar-dev-containers"
LABEL org.opencontainers.image.licenses="MIT"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install runtime tools and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    pkg-config \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add Soroban WebAssembly target for smart contract compilation
RUN rustup target add wasm32v1-none

# Copy pre-compiled stellar-cli binary from builder stage
COPY --from=builder /usr/local/cargo/bin/stellar /usr/local/cargo/bin/stellar

# Verify stellar binary installation
RUN stellar --version

# Set standard workspace directory
WORKDIR /workspace

# Default command displays Stellar CLI help
CMD ["stellar", "--help"]
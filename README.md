# protos

This repository contains **common Protobuf definitions** used across Luther Systems projects. These Protobufs define API contracts, configuration structures, and shared messages for various services.

## 📌 Overview

- Uses [Buf](https://buf.build/) for Protobuf linting, generation, and dependency management.
- Only `.proto` files are checked into this repository—generated code is excluded.
- Supports multiple services, including **health checks, connectors, and PDF generation**.

## 📂 Directory Structure

```
protos/
├── common/         # Shared messages and exceptions
├── connectors/     # Connector configurations (e.g., Camunda, Stripe, PostgreSQL)
├── healthcheck/    # Protos for service health checks
├── pdfserv/        # Protos for PDF generation services
├── .github/        # CI/CD workflows for Buf validation
├── buf.yaml        # Buf module configuration
├── buf.gen.yaml    # Code generation settings
├── buf.lock        # Buf dependency lockfile
└── LICENSE         # Repository license
```

## ⚡ Usage

### Install Buf

Ensure you have `buf` installed:

```bash
brew install buf
```

### Lint Protobuf Files

Check for any linting issues:

```bash
make proto-lint
```

### Generate Protobuf Code

Run the following command to generate code from the Protobuf definitions:

```bash
make proto-gen
```

### Cleanup Generated Files

To remove all generated `.pb.go` files:

```bash
make proto-clean
```

## 🔄 Updating Dependencies

To update `buf` dependencies:

```bash
buf mod update
```

## 🐜 License

This repository is licensed under the Luther Systems license. See [LICENSE](LICENSE) for details.

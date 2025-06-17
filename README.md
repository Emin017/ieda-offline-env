# ✨ ieda infrastructure

<div align="center">

![GitHub](https://img.shields.io/github/license/Emin017/ieda-infra)
![GitHub workflows](https://img.shields.io/github/actions/workflow/status/Emin017/ieda-infra/build.yml)
![GitHub issues](https://img.shields.io/github/issues/Emin017/ieda-infra)
![GitHub pull requests](https://img.shields.io/github/issues-pr/Emin017/ieda-infra)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/Emin017/ieda-infra)

![GitHub stars](https://img.shields.io/github/stars/Emin017/ieda-infra?style=social)
![GitHub forks](https://img.shields.io/github/forks/Emin017/ieda-infra?style=social)

[![English](https://img.shields.io/badge/English-README-2ea44f?style=for-the-badge)](README.md)
[![中文](https://img.shields.io/badge/中文-介绍-FF6F61?style=for-the-badge)](README_CN.md)

</div>

## Project Introduction

ieda-infra is a toolkit that provides development and runtime environments for [iEDA](https://gitee.com/oscc-project/iEDA). iEDA is an open-source EDA infrastructure and toolchain for ASIC design from netlist to GDS. This project offers a Nix-based development environment with all dependencies integrated for iEDA.

## Features

- 📦 Complete dependency management based on Nix
- 🔄 Offline development environment support
- 🐳 Pre-configured Docker images
- 🛠️ Multi-platform support (x86_64/aarch64, Linux/macOS)
- ⚙️ Integration of all iEDA dependencies

## System Requirements

- Supported operating systems:
  - Linux (x86_64, aarch64)
  - macOS (x86_64, aarch64)
- [Nix](https://nixos.org/download.html) (flakes feature required)

## Usage Guide

### Building iEDA with Nix

```bash
# Build and install iEDA with Nix
nix build -L github:Emin017/ieda-infra#ieda
```

> [!NOTE]
> We provide hydra builds for x86_64 architecture, which can be found in [Hydra Builds](https://hydra.eminrepo.cc/job/iEDA-Infra/iEDA-Infra/x86_64-linux.iedaUnstable/all)
>
> You can use the binary cache to speed up the build process:
> ```bash
> nix build -L github:Emin017/ieda-infra#iedaUnstable \
>   --option substituters "https://serve.eminrepo.cc/" \
>   --option trusted-public-keys "serve.eminrepo.cc:fgdTGDMn75Z0NOvTmus/Z9Fyh6ExgoqddNVkaYVi5qk="
> ```

### Packaging iEDA with Dependencies

```bash
# Package iEDA with all dependencies
# As RPM format
nix bundle -L --bundler github:NixOS/bundlers#toRPM github:Emin017/ieda-infra#ieda
# As DEB format
nix bundle -L --bundler github:NixOS/bundlers#toDEB github:Emin017/ieda-infra#ieda
# The generated packages can be used in offline environments
```

### Building Docker Image

```bash
# Build Docker image
nix build github:Emin017/ieda-infra#releaseDocker
```

### iEDA Offline Compilation Environment Package

```bash
# Build offline package
nix build -L github:Emin017/ieda-infra#offlineDevBundle

# The generated package can be copied to offline environments for compiling iEDA
```

### Using in Offline Environments

Using `RPM` as an example:

1. Copy the built `rpm-single-nix-env-wrapper-bin-nix-env-wrapper/nix-env-wrapper-bin-nix-env-wrapper-1.0-1.x86_64.rpm` to the target environment
2. Install with `yum`: `nix-env-wrapper-bin-nix-env-wrapper-1.0-1.x86_64.rpm`
3. Run the `nix-env-wrapper` script to enter the development environment
4. Follow the normal workflow to develop or build iEDA

## Project Structure

```
ieda-infra/
├── flake.nix              # Nix Flake configuration
├── nix/
│   ├── overlay.nix        # Nix overlay configuration
│   ├── pkgs/              # Package definitions
│   │   ├── ieda/          # iEDA main package
│   │   └── rustpkgs/      # Rust dependency packages
│   └── env/               # Environment configurations
│       ├── offline/       # Offline environment
│       └── docker.nix     # Docker image configuration
└── README.md              # Project documentation
```

## Contribution Guidelines

Contributions of any form are welcome!

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the Mulan Permissive Software License v2 (Mulan PSL v2). See the [LICENSE](LICENSE) file for details.

## Related Projects

- [iEDA](https://gitee.com/oscc-project/iEDA) - Open-source EDA infrastructure and tools
- [Nix](https://nixos.org/) - Reproducible package manager


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

## 项目介绍

ieda-infra 是一个为 [iEDA](https://gitee.com/oscc-project/iEDA) 提供开发和运行环境的工具包。iEDA 是一套开源 EDA 基础架构和工具，用于从网表到 GDS 的 ASIC 设计流程。本项目提供了一个基于 Nix 的开发环境，并集成了所有 iEDA 依赖。

## 功能特性

- 📦 基于 Nix 的完整依赖管理
- 🔄 离线开发环境支持
- 🐳 提供预配置的 Docker 镜像
- 🛠️ 多平台支持 (x86_64/aarch64, Linux/macOS)
- ⚙️ 集成了所有 iEDA 依赖

## 系统要求

- 支持的操作系统:
  - Linux (x86_64, aarch64)
  - macOS (x86_64, aarch64)
- [Nix](https://nixos.org/download.html) (需要启用 flakes 功能)

## 使用指南

### 使用 Nix 构建 iEDA

```bash
# 使用 Nix 构建并安装 iEDA
nix build -L github:Emin017/ieda-infra#ieda
```

> [!NOTE]
> 我们提供了 x86_64 架构的 Hydra 构建，可以在 [Hydra Builds](https://hydra.eminrepo.cc/job/iEDA-Infra/iEDA-Infra/x86_64-linux.iedaUnstable/all) 中找到
>
> 我们可以通过使用二进制缓存来加速构建过程:
> ```bash
> nix build -L github:Emin017/ieda-infra#iedaUnstable \
>   --option substituters "https://serve.eminrepo.cc/" \
>   --option trusted-public-keys "serve.eminrepo.cc:fgdTGDMn75Z0NOvTmus/Z9Fyh6ExgoqddNVkaYVi5qk="
> ```

### 使用 Nix 构建 iEDA

```bash
# 打包 iEDA 以及所有依赖
# 打包为 RPM 格式
nix bundle -L --bundler github:NixOS/bundlers#toRPM github:Emin017/ieda-infra#ieda
# 打包为 DEB 格式
nix bundle -L --bundler github:NixOS/bundlers#toDEB github:Emin017/ieda-infra#ieda
# 生成的包可以在离线环境中使用
```

### 构建 Docker 镜像

```bash
# 构建 Docker 镜像
nix build github:Emin017/ieda-infra#releaseDocker
```

### iEDA 离线编译环境包

```bash
# 构建离线包
nix build -L github:Emin017/ieda-infra#offlineDevBundle

# 生成的包可以复制到离线环境中用于编译 iEDA
```

### 离线环境使用

用 `RPM` 举例:

1. 将构建好的 `rpm-single-nix-env-wrapper-bin-nix-env-wrapper/nix-env-wrapper-bin-nix-env-wrapper-1.0-1.x86_64.rpm` 复制到目标环境
2. 用 `yum` 安装 `nix-env-wrapper-bin-nix-env-wrapper-1.0-1.x86_64.rpm`
3. 运行 `nix-env-wrapper` 脚本进入开发环境
4. 按照正常流程开发或构建 iEDA

## 项目结构

```
ieda-infra/
├── flake.nix              # Nix Flake 配置
├── nix/
│   ├── overlay.nix        # Nix overlay 配置
│   ├── pkgs/              # 包定义
│   │   ├── ieda/          # iEDA 主包
│   │   └── rustpkgs/      # Rust 依赖包
│   └── env/               # 环境配置
│       ├── offline/       # 离线环境
│       └── docker.nix     # Docker 镜像配置
└── README.md              # 项目文档
```

## 贡献指南

欢迎任何形式的贡献！

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交您的更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 开启一个 Pull Request

## 许可证

本项目采用木兰宽松许可证第二版（Mulan PSL v2）进行许可。详情请参阅 [LICENSE](LICENSE) 文件。

## 相关项目

- [iEDA](https://gitee.com/oscc-project/iEDA) - 开源 EDA 基础架构和工具
- [Nix](https://nixos.org/) - 可复现的包管理器
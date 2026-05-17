# .machine.config

A centralized collection of configuration files, dotfiles, and setup scripts to automate the provisioning of my development environment.

## 🚀 Overview

This repository serves as the "source of truth" for my machine setup. It ensures consistency across different hardware and allows for a rapid "reset" if I need to wipe my machine or set up a new one.

## 📦 What's Inside

- Dotfiles: Configurations for bash.
- Installers: Scripts for MariaDB, Meowdo.
- Setup: DFK, FastFetch, Zellij.

## 🛠 Installation

> [!WARNING] Running these scripts will overwrite existing local configurations. Back up your data first.

### Clone the repository

```bash
git clone https://github.com/mind0bender/.machine.config.git
```

### Navigate to the directory

```bash
cd .machine.config
```

## Available Scripts

### MariaDB Installer

```bash
mariadb.sh
```

### Meowdo Installer

```bash
meowdo.sh
```

### FastFetch Logo

```bash
cd setup
bun i
bun setup fastfetch
```

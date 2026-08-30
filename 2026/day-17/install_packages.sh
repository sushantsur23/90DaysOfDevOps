#!/bin/bash
if [ "$EUID" -ne 0 ]; then echo "Error: Run this script as root or with sudo."; exit 1; fi
PACKAGES=(nginx curl wget)
if command -v apt-get >/dev/null 2>&1; then PM=apt-get; elif command -v dnf >/dev/null 2>&1; then PM=dnf; elif command -v yum >/dev/null 2>&1; then PM=yum; else echo "Error: No supported package manager found."; exit 1; fi
for package in "${PACKAGES[@]}"; do
  if command -v "$package" >/dev/null 2>&1; then echo "$package: already installed — skipping."; else echo "$package: not installed — installing..."; "$PM" install -y "$package" || { echo "Error: Failed to install $package."; exit 1; }; fi
done

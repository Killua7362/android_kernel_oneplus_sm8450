#!/bin/bash

function compile() 
{
    # Enable ccache
    export USE_CCACHE=1
    ccache -M 100G

    # Kernel Build Info
    export ARCH=arm64
    export KBUILD_BUILD_HOST="killuaa"
    export KBUILD_BUILD_USER="killua"
    export LOCALVERSION="-v1.0"

    # Define Clang directory
    export CLANG_DIR="~/repo/clang18/bin/clang-18"
    # Clone Clang if missing
 #   if [ ! -f "$CLANG_DIR/bin/clang" ]; then
  #      echo "[*] Cloning Clang..."
  #      git clone --depth=1 https://github.com/Kdrag0n/proton-clang.git "$CLANG_DIR"
  #  fi

    # Set Clang Paths
    export PATH="${CLANG_DIR}/bin:${PATH}"
    export CC=clang
    export CLANG_TRIPLE=aarch64-linux-gnu
    export LLVM=1
    export LLVM_IAS=1

    # Ensure 'out' directory exists
    # mkdir -p out

    # Compile Kernel
    make O=out ARCH=arm64 CC=clang gki_defconfig vendor/waipio_GKI.config vendor/oplus_GKI.config vendor/debugfs.config
    make O=out ARCH=arm64 CC=clang -j$(nproc)
}

compile

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


    export CLANG_ROOT=~/repo/clang18
    export CLANG_PATH=${CLANG_ROOT}/bin
    export PATH=${CLANG_PATH}:${PATH}
    export LD_LIBRARY_PATH=${CLANG_ROOT}/lib64:$LD_LIBRARY_PATH
    export CLANG_TRIPLE=aarch64-linux-gnu-
    export LLVM=1
    export LLVM_IAS=1

    # Ensure 'out' directory exists
    # mkdir -p out

    # Compile Kernel
    make O=out ARCH=arm64 CC="ccache clang" gki_defconfig
    make O=out ARCH=arm64 CC="ccache clang" -j$(nproc)
}

compile

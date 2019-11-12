#!/bin/bash

set -euo pipefail

VM_VERSION="201911012148"
BASE_VM_DOWNLOAD_PATH="https://github.com/OpenSmalltalk/opensmalltalk-vm/releases/download/$VM_VERSION"
VM_FILENAME="squeak.cog.spur_linux64x64_$VM_VERSION"

wget "$BASE_VM_DOWNLOAD_PATH/$VM_FILENAME.tar.gz"
tar -xvzf "$VM_FILENAME.tar.gz"

sqcogspur64linuxht/squeak --version

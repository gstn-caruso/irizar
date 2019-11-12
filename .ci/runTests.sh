#!/bin/bash

set -euo pipefail

cd Cuis-Smalltalk-Dev

IMAGE_FILE="$(ls | grep 'Cuis5.0-[0-9]\+.image')"
RUN_TESTS_SCRIPT_FILEPATH="../.ci/runTests.st"

../sqcogspur64linuxht/squeak -vm-display-null "$IMAGE_FILE" -s "$RUN_TESTS_SCRIPT_FILEPATH"

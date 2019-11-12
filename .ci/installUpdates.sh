#!/bin/bash

set -euo pipefail

cd Cuis-Smalltalk-Dev

IMAGE_FILE="$(ls | grep 'Cuis5.0-[0-9]\+.image')"

INSTALL_UPDATES_SCRIPT="\
  Utilities classPool at: #AuthorName put: 'TravisCI'.
  Utilities classPool at: #AuthorInitials put: 'TCI'.
  ChangeSet installNewUpdates.\
  Smalltalk snapshot: true andQuit: true clearAllClassState: false.\
"

../sqcogspur64linuxht/squeak -vm-display-null "$IMAGE_FILE" -d "$INSTALL_UPDATES_SCRIPT"

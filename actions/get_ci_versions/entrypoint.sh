#!/bin/bash -l

set -o pipefail

PREFERRED_FLUTTER_VERSION="1.22.1"
PREFERRED_FLUTTER_CHANNEL="stable"

echo "::set-output name=flutter_version::$PREFERRED_FLUTTER_VERSION"
echo "::set-output name=flutter_channel::$PREFERRED_FLUTTER_CHANNEL"

#!/bin/bash

set -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJ_ROOT="$(dirname "$SCRIPT_DIR")"
ACTION_ROOT="$PROJ_ROOT/actions"
echo "Use $ACTION_ROOT as the actions directory."

cd "$ACTION_ROOT/get_ci_versions"
npm install

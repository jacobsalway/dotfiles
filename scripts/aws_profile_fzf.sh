#!/bin/bash

set -Euo pipefail

profile=$(aws configure list-profiles | fzf)

if [ -n "$profile" ]; then
    export AWS_PROFILE="$profile"
    echo "Exported AWS_PROFILE=$profile"
fi


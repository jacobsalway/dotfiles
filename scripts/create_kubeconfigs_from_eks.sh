#!/bin/bash
set -Euo pipefail

REGIONS=(
    "us-west-2"
    # ...
)

update_kubeconfig() {
    profile=$1
    region=$2

    clusters=$(aws eks list-clusters --region $region --profile $profile --query "clusters" |
        jq -r '.[]')

    for cluster in $clusters; do
        alias="$cluster-$region-$profile"
        aws eks update-kubeconfig --profile $profile --region $region --name $cluster \
            --alias $alias
    done
}

temp_file=$(mktemp)
for profile in $(aws configure list-profiles); do
    for region in ${REGIONS[@]}; do
        echo $profile $region >> $temp_file
    done
done

# It's probably possible to speed this up with -j
export -f update_kubeconfig
cat "$temp_file" | xargs -n 2 bash -c 'update_kubeconfig "$@"' --


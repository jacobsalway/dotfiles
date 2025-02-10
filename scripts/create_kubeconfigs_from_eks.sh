#!/bin/bash

set -Euo pipefail

start=$(date +%s)

temp_file=$(mktemp)
temp_dir=$(mktemp -d)
trap 'rm -f $temp_file' EXIT
trap 'rm -rf $temp_dir' EXIT

echo "Getting profiles..."

for profile in $(aws configure list-profiles); do
    (
        if aws sts get-caller-identity --profile "$profile" &>/dev/null; then
            echo "$profile" >> "$temp_file"
        else
            echo "Skipping $profile"
        fi
    ) &
done
wait

profiles=()
while IFS= read -r line; do
    profiles+=("$line")
done < "$temp_file"
> "$temp_file"

echo "Getting regions for ${#profiles[@]} profiles..."

for profile in "${profiles[@]}"; do
    (
        regions=$(aws ec2 describe-regions --profile "$profile" --output text --query 'Regions[].RegionName' 2>/dev/null)
        for region in $regions; do
            echo "$profile $region" >> "$temp_file"
        done
    ) &
done
wait

profile_regions=()
while IFS= read -r line; do
    profile_regions+=("$line")
done < "$temp_file"
> "$temp_file"

echo "Getting EKS clusters for ${#profile_regions[@]} profile and region combinations..."

for profile_region in "${profile_regions[@]}"; do
    (
        profile=$(awk '{print $1}' <<< "$profile_region")
        region=$(awk '{print $2}' <<< "$profile_region")
        clusters=$(aws eks list-clusters --profile "$profile" --region "$region" --output text --query 'clusters' 2>/dev/null)
        for cluster in $clusters; do
            echo "$profile $region $cluster" >> "$temp_file"
        done
    ) &
done
wait

profile_region_clusters=()
while IFS= read -r line; do
    profile_region_clusters+=("$line")
done < "$temp_file"
> "$temp_file"

echo "Generating kubeconfigs for ${#profile_region_clusters[@]} EKS clusters..."

for profile_region_cluster in "${profile_region_clusters[@]}"; do
    (
        profile=$(awk '{print $1}' <<< "$profile_region_cluster")
        region=$(awk '{print $2}' <<< "$profile_region_cluster")
        cluster=$(awk '{print $3}' <<< "$profile_region_cluster")
        aws eks update-kubeconfig --profile "$profile" --region "$region" --name "$cluster" --alias "$cluster-$region-$profile" --kubeconfig "$temp_dir/$profile-$region-$cluster-kubeconfig"
    ) &
done
wait

echo "Merging kubeconfigs..."
KUBECONFIG=$(find "$temp_dir" -type f | tr '\n' ':') kubectl config view --flatten > ~/.kube/config

echo "Generated kubeconfigs in $(( $(date +%s) - start )) seconds"

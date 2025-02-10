#!/bin/bash

set -Euo pipefail

# Inspired by https://github.com/aws-samples/aws-sso-profile-tool/blob/main/awsssoprofiletool.sh

if [ "$#" -lt 2 ]; then
    echo "Usage: <sso_start_url> <sso_region>"
    exit 1
fi

START_URL=$1
REGION=$2

echo "Registering client..."
out=$(aws sso-oidc register-client --client-name profiletool --client-type public \
    --region "$REGION" --output text)
secret=$(awk -F ' ' '{print $3}' <<< "$out")
clientid=$(awk -F ' ' '{print $1}' <<< "$out")

echo "Starting device authorisation..."
out=$(aws sso-oidc start-device-authorization --client-id "$clientid" --client-secret "$secret" \
    --start-url "$START_URL" --region "$REGION" --output text)
regurl=$(awk -F ' ' '{print $6}' <<< "$out")
devicecode=$(awk -F ' ' '{print $1}' <<< "$out")

python -c "import webbrowser; webbrowser.open('$regurl')"

# TODO: figure out how to listen for whether allow has been clicked
echo "Open $regurl and click allow. Press <Enter> after signed in"
read continue

echo "Getting access token..."
out=$(aws sso-oidc create-token --client-id "$clientid" --client-secret "$secret" --grant-type \
    'urn:ietf:params:oauth:grant-type:device_code' --device-code "$devicecode" --region "$REGION" --output text)
token=$(awk -F ' ' '{print $1}' <<< "$out")

echo "Retrieving accounts..."
accounts=$(aws sso list-accounts --access-token "$token" --region "$REGION" --output text)

# Make the account name CLI friendly
# e.g. "Company (Prod)" -> "company-prod"
script="
import sys

result = sys.argv[1].lower().strip()\
    .replace(' ', '-').replace('(', '').replace(')', '')
print(result)
"

touch profiles

echo "[sso-session sso]" >> profiles
echo "sso_region = $REGION" >> profiles
echo "sso_start_url = $START_URL" >> profiles

echo "$accounts" | while IFS=$'\t' read -r skip accountnum accountname skip; do
    sanitised_accountname=$(python -c "$script" "$accountname")

    echo "Getting roles for '$accountname' ($sanitised_accountname)"
    roles=$(aws sso list-account-roles --account-id "$accountnum" --access-token "$token" \
        --region "$REGION" --output text)

    echo "$roles" | while IFS=$'\t' read -r skip skip rolename; do
        echo "Got role $rolename"
        sanitised_rolename=$(python -c "$script" "$rolename")

        echo "" >> profiles
        echo "[profile $sanitised_accountname-$sanitised_rolename]" >> profiles
        echo "sso_session = sso" >> profiles
        echo "sso_account_id = $accountnum" >> profiles
        echo "sso_role_name = $rolename" >> profiles
        echo "region = $REGION" >> profiles
        echo "output = json" >> profiles
    done
done

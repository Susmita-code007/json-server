#!/bin/bash

JSON_FILE=$1

if [[ -z "$JSON_FILE" || ! -f "$JSON_FILE" ]]; then
    echo "Usage: $0 <json_file>"
    exit 1
fi

echo "📦 Checking packages from '$JSON_FILE'..."

# Read JSON and loop through packages
while IFS= read -r line; do
    PACKAGE_NAME=$(echo "$line" | jq -r '.name')
    PACKAGE_VERSION=$(echo "$line" | jq -r '.version')

    if [[ -n "$PACKAGE_NAME" && -n "$PACKAGE_VERSION" ]]; then
        echo "🔍 Checking $PACKAGE_NAME@$PACKAGE_VERSION..."
        ./check_package.sh "$PACKAGE_NAME" "$PACKAGE_VERSION"
        echo "-----------------------------------"
    fi
done < <(jq -c '.[]' "$JSON_FILE")

echo "✅ Package check completed!"


#!/bin/bash

PACKAGE_NAME=$1
VERSION=$2

if [[ -z "$PACKAGE_NAME" || -z "$VERSION" ]]; then
    echo "Usage: $0 <package_name> <version>"
    exit 1
fi

echo "Searching for package '$PACKAGE_NAME' with version '$VERSION' in node_modules..."

while IFS= read -r dir; do
    PACKAGE_JSON="$dir/package.json"

    if [[ -f "$PACKAGE_JSON" ]]; then
        if command -v jq >/dev/null 2>&1; then
            PACKAGE_VERSION=$(jq -r '.version' "$PACKAGE_JSON")
        else
            PACKAGE_VERSION=$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' "$PACKAGE_JSON")
        fi

        if [[ "$PACKAGE_VERSION" == "$VERSION" ]]; then
            echo "✅ Found: $dir (Version: $PACKAGE_VERSION)"
            echo "📂 Path: $(realpath "$PACKAGE_JSON")"
            exit 0  # Stop the script once found
        fi
    fi
done < <(find node_modules -type d -name "$PACKAGE_NAME")

echo "❌ Package '$PACKAGE_NAME' with version '$VERSION' not found."
exit 1


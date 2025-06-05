#!/bin/bash

# Define the URL and output file
URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
OUTPUT_FILE="main-hosts"

# Fetch the hosts content and write it to the main-hosts file
echo "Downloading hosts file from $URL..."
curl -fsSL "$URL" -o "$OUTPUT_FILE"

# Check if the download succeeded
if [ $? -eq 0 ]; then
    echo "Successfully updated $OUTPUT_FILE"
else
    echo "Failed to download the hosts file" >&2
    exit 1
fi

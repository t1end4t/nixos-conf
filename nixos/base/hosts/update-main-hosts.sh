#!/bin/bash

# Define the URL and output file
URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
OUTPUT_FILE="main-hosts"

# Fetch the hosts content and write it to the main-hosts file
echo "Downloading hosts file from $URL..."
curl -fsSL "$URL" -o "$OUTPUT_FILE"

# Check if the download succeeded
if [ $? -eq 0 ]; then
    echo "Successfully updated $OUTPUT_FILE"
    
    # Comment out Reddit section (starting with "# Reddit" and all following non-comment lines until next comment or EOF)
    # echo "Commenting out Reddit section..."
    # awk '
    # /^# Reddit$/ { 
    #     in_reddit_section = 1
    #     print "# " $0
    #     next
    # }
    # in_reddit_section && /^[0-9]/ { 
    #     print "# " $0
    #     next
    # }
    # in_reddit_section && /^#/ { 
    #     in_reddit_section = 0
    # }
    # { print }
    # ' "$OUTPUT_FILE" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
    
    # Comment out Twitter section (starting with "# Twitter" and all following non-comment lines until next comment or EOF)
    # echo "Commenting out Twitter section..."
    # awk '
    # /^# Twitter$/ { 
    #     in_twitter_section = 1
    #     print "# " $0
    #     next
    # }
    # in_twitter_section && /^[0-9]/ { 
    #     print "# " $0
    #     next
    # }
    # in_twitter_section && /^#/ { 
    #     in_twitter_section = 0
    # }
    # { print }
    # ' "$OUTPUT_FILE" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
    
    # echo "Reddit and Twitter sections commented out"
else
    echo "Failed to download the hosts file" >&2
    exit 1
fi

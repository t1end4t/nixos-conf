#!/usr/bin/env bash
set -e

# @describe Get the current weather in a given location.
# @option --location! The city and optionally the state or country, e.g., "London", "San Francisco, CA".

# @env LLM_OUTPUT=/dev/stdout The output path

main() {
    curl -fsSL "https://wttr.in/$(echo "$argc_location" | sed 's/ /+/g')?format=4&M" \
    >> "$LLM_OUTPUT"
}

eval "$(argc --argc-eval "$0" "$@")"

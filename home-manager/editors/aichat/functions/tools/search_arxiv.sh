#!/usr/bin/env bash
set -e

# @describe Search arXiv for a query and return the top papers.

# @option --query! The query to search for.

# @env ARXIV_MAX_RESULTS=3 The max results to return.
# @env LLM_OUTPUT=/dev/stdout The output path

main() {
    encoded_query="$(jq -nr --arg q "$argc_query" '$q|@uri')"
    url="http://export.arxiv.org/api/query?search_query=all:$encoded_query&max_results=$ARXIV_MAX_RESULTS"
    curl -fsSL "$url" >> "$LLM_OUTPUT"
}

eval "$(argc --argc-eval "$0" "$@")"

#!/usr/bin/env bash

# Define the function
settings() {
    local yaml_file=/home/jorge/.config/mydots/settings.yaml
    local search_value=$1

    # Check if file exists
    if [ ! -f "$yaml_file" ]; then
        echo "Error: YAML file '$yaml_file' not found."
        exit 1
    fi

    # Search for the value in the YAML file using yq
    local result=$(yq -r ".$search_value" $yaml_file)
    # Check if any result is found
    if [ -z "$result" ]; then
	return 1
    else
        echo "$result"
	return 0
    fi
}



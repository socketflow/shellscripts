#!/bin/bash

# Log file to analyze
LOG_FILE="/var/log/sing-box/sing-box.log"

# File to update
FILE="blacklist_dynamic_ips.txt"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file $LOG_FILE does not exist."
    exit 1
else
    echo "Log file found: $LOG_FILE"
fi

# Check for multiple patterns in the log file and extract IP addresses
echo "Searching for malicious patterns in the log file..."
if ! grep -E "bad path" "$LOG_FILE"* | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort -u > "$FILE.tmp"; then
    echo "No matching patterns found or an error occurred."
    exit 1
else
    echo "Malicious patterns found. Processing IP addresses..."
fi

# Check if temporary file with IPs is non-empty before proceeding
if [ ! -s "$FILE.tmp" ]; then
    echo "No IP addresses were extracted. Exiting."
    # rm "$FILE.tmp"
    exit 1
else
    echo "IP addresses extracted successfully."
fi

# Remove duplicates and update the blacklist file
if sort -u "$FILE.tmp" > "$FILE"; then
    echo "Blacklist file $FILE has been updated successfully."
    rm "$FILE.tmp" # Clean up temporary file
else
    echo "Error updating the blacklist file."
    exit 1
fi

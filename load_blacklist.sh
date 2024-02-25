#!/bin/bash

FILE="blacklist_dynamic_ips.txt"
BATCH_FILE="blacklist_batch_file.nft"

# Start with a clean batch file
echo "" > $BATCH_FILE

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "File $FILE does not exist."
    exit 1
fi

# Add each IP address to the batch file
while IFS= read -r line
do
  echo "add element inet filter blacklist_dynamic { $line }" >> $BATCH_FILE
done < "$FILE"

# Clear the existing blacklist_dynamic set
nft flush set inet filter blacklist_dynamic

echo "Old IPs of blacklist_dynamic have been cleared out."

# Apply the batch file
nft -f $BATCH_FILE

echo "All IPs have been added to the blacklist_dynamic set using a batch update."

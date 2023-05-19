#!/bin/bash

# Check for input parameters
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <size in MB>"
    exit 1
fi

# File to write
FILE="dummy_data.csv"

# Remove file if it exists
if [ -f "$FILE" ]; then
    echo "Removing existing file $FILE"
    rm -f "$FILE"
fi

# Write CSV header
echo "LASTNAME,ASSISTANTNAME,ASSISTANTPHONE,BIRTHDATE,DEPARTMENT,DESCRIPTION,HOMEPHONE,MOBILEPHONE,OTHERPHONE,PHONE,TITLE"  >> $FILE

# File size limit in bytes (input size in MB * 1024 * 1024)
SIZE=$(( $1 * 1024 * 1024 ))

# Current file size
CURRENT_SIZE=0

#TIMESTAMP
TIMESTAMP=$(date +%s)
# ID counter
ID="$TIMESTAMP"

# Return random string of specified length
function generate_random_string {
    perl -le 'print map { (a..z,A..Z,0..9)[rand 62] } 1..'${1}
}

ASSISTANTNAME=$(generate_random_string 40)
ASSISTANTPHONE="234-234-2345"
BIRTHDATE="2017-01-01"
DEPARTMENT=$(generate_random_string 80)
DESCRIPTION=$(generate_random_string 31500)
# EMAIL="foo@example.com" # Removed email since it needs to be unique (could disable unique-check in UI but this is easier)
HOMEPHONE="555-555-5555"
MOBILEPHONE="555-555-5555"
NAME=$ID
LASTNAME=$ID
OTHERPHONE="555-555-5555"
PHONE="555-555-5555"
TITLE=$(generate_random_string 128)

# Generate CSV data until file size limit is reached
while [ "$CURRENT_SIZE" -lt $SIZE ]
do
    echo "$LASTNAME,$ASSISTANTNAME,$ASSISTANTPHONE,$BIRTHDATE,$DEPARTMENT,$DESCRIPTION,$HOMEPHONE,$MOBILEPHONE,$OTHERPHONE,$PHONE,$TITLE" >> $FILE
    CURRENT_SIZE=$(stat -f%z "$FILE")
    LASTNAME=$((LASTNAME+1))
done


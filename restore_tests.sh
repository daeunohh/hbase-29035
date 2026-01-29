#!/bin/bash

COMMIT_ID=$1
LIST_FILE="testfiles.txt"

echo "Restoring test files listed in $LIST_FILE ..."
echo

while IFS= read -r FILE; do
  # Skip empty lines
  if [[ -z "$FILE" ]]; then
    continue
  fi

  DEST_DIR=$(dirname "$FILE")

  # Create directory if not exist
  if [ ! -d "$DEST_DIR" ]; then
    echo "Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR"
  fi

  echo "Restoring $FILE ..."
  
  # Extract file from commit
  git show "$COMMIT_ID:$FILE" > "$FILE"

  if [ $? -eq 0 ]; then
    echo "✔ Restored: $FILE"
  else
    echo "✖ Failed to restore: $FILE"
  fi

  echo
done < "$LIST_FILE"

echo "----------------------------------------"
echo "Restore completed using commit $COMMIT_ID"
echo "----------------------------------------"

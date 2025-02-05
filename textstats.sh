#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

if [ ! -f "$filename" ]; then
  echo "Error: '$filename' is not a file."
  exit 1
fi

total_words=0
line_count=0
longest_line=""
max_words=0

while IFS= read -r line; do
  line_count=$((line_count + 1))
  word_count=$(echo "$line" | wc -w)
  total_words=$((total_words + word_count))
  echo "Line $line_count: $word_count words"

  if (( word_count > max_words )); then
    max_words="$word_count"
    longest_line="Line $line_count ($word_count words)"
  fi

done < "$filename"

if (( line_count > 0 )); then  # Avoid division by zero
  average_words=$((total_words / line_count))
  echo "Average words per line: $average_words"
else
    echo "File is empty."
fi

echo "Longest line: $longest_line"

exit 0

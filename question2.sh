# Function to count and list file types
count_file_types() {
  local dir="$1"
  
  # Check if the directory exists
  if [ ! -d "$dir" ]; then
    echo "Directory does not exist."
    exit 1
  fi

  # Find all non-hidden files recursively, extract file extensions, and count occurrences
  find "$dir" -type f ! -path '*/\.*' | awk -F. '
    {
      if (NF>1) {
        ext = $NF
        count[ext]++
      } else {
        count["no_extension"]++
      }
    }
    END {
      printf "%-15s %s\n", "File Type", "Count"
      printf "%-15s %s\n", "---------", "-----"
      for (ext in count) {
        printf "%-15s %d\n", ext, count[ext]
      }
    }
  ' | sort
}

# Check if a directory was provided as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Call the function with the provided directory
count_file_types "$1"
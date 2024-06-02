# Check if a file path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

# Check if the file exists and is readable
if [ ! -f "$1" ] || [ ! -r "$1" ]; then
    echo "Error: Log file not found or not readable."
    exit 1
fi

# Count total requests
totalRequests=$(grep -c ".*" "$1")

# Calculate percentage of successful requests
successRequests=$(grep -E '" (2[0-9]{2}) ' "$1" | wc -l | tr -d ' ')
percentageSuccess=$(echo "scale=2; ($successRequests / $totalRequests) * 100" | bc)

# Find the IP address with the most requests
mostActiveUser=$(awk '{print $1}' "$1" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')

# Output the results
echo "The Total Requests Count is: $totalRequests"
echo "The Percentage of Successful Requests is: $percentageSuccess%"
echo "The Most Active User is: $mostActiveUser"

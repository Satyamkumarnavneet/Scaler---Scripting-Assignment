# Function to check the status of a service
check_service_status() {
  local service="$1"

  # Check if the service name is provided
  if [ -z "$service" ]; then
    echo "Usage: $0 <service_name>"
    exit 1
  fi

  # Check if the service process is running using ps
  if ps aux | grep -v grep | grep -qw "$service"; then
    echo "The service '$service' is running."
  else
    echo "The service '$service' is not running."
  fi
}

# Call the function with the provided service name
check_service_status "$1"

#! /bin/bash

# Define the threshold values for CPU, memory, and disk usage
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Function to send an alert

send_alert() {
    echo "$(tput setaf 1)ALERT: $1 usage exceeded threshold! Current value: $2%$(tput sgr0)" 
    #the command tput setaf 1 is used to change the foreground color of text in the terminal. The setaf parameter stands for "set ANSI foreground," and the number 1 corresponds to the color red.
    #the command tput sgr0 is used to reset terminal attributes to their default settings. The sgr0 stands for "Set Graphics Rendition 0," which restores text to its default appearance by clearing color, boldness, underlining, or any other formatting applied.
}

# Monitor CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage=${cpu_usage%.*} # Convert to integer
echo "Current CPU usage: $cpu_usage%"

if ((cpu_usage >= CPU_THRESHOLD)); then
  send_alert "CPU" "$cpu_usage"
fi

# Monitor memory usage
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
memory_usage=${memory_usage%.*} # Convert to integer
echo "Current Memory usage: $memory_usage%"
if ((memory_usage >= MEMORY_THRESHOLD)); then
  send_alert "Memory" "$memory_usage"
fi

# # Monitor disk usage
# disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
# echo "Current Disk usage: $disk_usage%"
# if ((disk_usage >= DISK_THRESHOLD)); then
#   send_alert "Disk" "$disk_usage"
# fi
# # Log the current usage to a file
# log_file="system_monitor.log"
# echo "$(date): CPU: $cpu_usage%, Memory: $memory_usage%, Disk: $disk_usage%" >> "$log_file"
# # Display the log file content
# echo "System usage logged to $log_file"
# # Display the log file content
# echo "Log file content:"
# cat "$log_file"
# # End of script
# # This script monitors system resources and sends alerts if usage exceeds defined thresholds.
# # It logs the current usage to a file and displays the log content.
# # Usage: Save this script as system_monitor.sh, make it executable with chmod +x system_monitor.sh, and run it with ./system_monitor.sh
# # End of script
# # Usage: Save this script as system_monitor.sh, make it executable with chmod +x system_monitor.sh, and run it with ./system_monitor.sh
# # End of script
# # Usage: Save this script as system_monitor.sh, make it executable with chmod +x system_monitor.sh, and run it with ./system_monitor.sh
# # Usage: Save this script as system_monitor.sh, make it executable with chmod +x system_monitor.sh, and run it with ./system_monitor.sh
# # Usage: Save this script as system_monitor.sh, make it executable with chmod +x system_monitor.sh, and run it with ./system_monitor.sh
# # Usage: Save this script as system_monitor.sh, make it executable with chmod +x system_monitor.sh, and run it with ./system_monitor.sh 
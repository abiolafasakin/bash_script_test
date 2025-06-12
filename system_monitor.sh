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

while true; do
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

    # Monitor disk usage
    disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    echo "Current Disk usage: $disk_usage%"
    if ((disk_usage >= DISK_THRESHOLD)); then
    send_alert "Disk" "$disk_usage"
    fi

    # Display current stats
    clear
    echo "Resource Usage:"
    echo "CPU: $cpu_usage%"
    echo "Memory: $memory_usage%"
    echo "Disk: $disk_usage%"
    sleep 2

    #Adding a logging feature to the system monitor script
    log_usage() {
        echo "$(date '+%Y-%m-%d %H:%M:%S') - CPU: $cpu_usage%, Memory: $memory_usage%, Disk: $disk_usage%" >> resource_usage.log
    }
    # Call the log_usage function after displaying the stats
    log_usage
done

# Note: This script runs indefinitely. To stop it, you can use Ctrl+C in the terminal.
# Ensure the script is executable
# To run the script, use the command: ./system_monitor.sh
# Note: This script requires root privileges to access certain system information.
# You can run it with sudo: sudo ./system_monitor.sh
# Usage: ./system_monitor.sh



#!/bin/bash

# Load config
source config.env

LOG_FILE="/home/eddy/Desktop/GithubProject/monitor.log"

while true; do
    DATE=$(date '+%Y-%m-%d %H:%M:%S')

    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    RAM=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
    DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    APACHE=$(systemctl is-active apache2 2>/dev/null)

    echo "$DATE | CPU: $CPU% | RAM: $RAM% | Disk: $DISK% | Apache: $APACHE" >> $LOG_FILE

    if (( ${CPU%.*} > $CPU_THRESHOLD )); then
      echo "High CPU usage: $CPU%" | mail -s "Alert: CPU" $ALERT_EMAIL
    fi

    if (( ${RAM%.*} > $RAM_THRESHOLD )); then
      echo "High RAM usage: $RAM%" | mail -s "Alert: RAM" $ALERT_EMAIL
    fi

    if (( $DISK > $DISK_THRESHOLD )); then
      echo "High Disk usage: $DISK%" | mail -s "Alert: Disk" $ALERT_EMAIL
    fi

    if [[ "$APACHE" != "active" ]]; then
      echo "Apache is down! Restarting..." | mail -s "Alert: Apache" $ALERT_EMAIL
      sudo systemctl restart apache2
    fi

    sleep 60   # wait 1 minute before checking again
done


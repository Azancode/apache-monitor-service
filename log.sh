#!/bin/bash

# Path for custom log
LOGFILE="/var/log/ssh-blocker.log"

# Look for failed SSH logins and extract IPs
grep --text "Failed password" /var/log/auth.log | awk '{print $(NF-3)}' | sort | uniq -c | while read count ip; do
    if [ "$count" -gt 3 ]; then
        # Block the IP if not already blocked
        if ! iptables -L INPUT -n | grep -q "$ip"; then
            iptables -A INPUT -s "$ip" -j DROP
            echo "$(date) - Blocked $ip after $count failed attempts" >> "$LOGFILE"
        fi
    fi
done


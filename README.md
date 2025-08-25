# Apache Auto-Restart Monitor Service

This project provides a simple **Bash script** and a **systemd service** to monitor the Apache web server (`apache2`/`httpd`).  
If Apache stops running, the service will automatically restart it to ensure uptime.  

## Features
- Monitors Apache status every 60 seconds  
- Automatically restarts Apache if down  
- Runs as a background systemd service  
- Simple and lightweight (no external dependencies)  

## Installation
1. Clone the repository:
   #bash
   git clone https://github.com/YOUR-USERNAME/apache-monitor-service.git
   cd apache-monitor-service
2. Make the script executable:
   #bash
   chmod +x monitor.sh
3. Copy the service file:
   sudo cp monitor.service /etc/systemd/system/
4. Reload systemd and enable service:
   sudo systemctl daemon-reload
5. Enable monitor service:
   sudo systemctl enable monitor.service
6. 
   sudo systemctl start monitor.service
   
7. Check Status:
   sudo systemctl status monitor.service


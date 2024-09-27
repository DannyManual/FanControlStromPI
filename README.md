# FanControlStromPI
Bash Skript and Debian Service for PWM Based Fan Control using pigpiod and pigs

# Requirements
- Raspberry PI with StromPi Set an Fan connected to GPIO 2.
- Raspberry Pi OS
- No other service using GPIO 2
- package pigpio installed

# Installation
Copy fantmppwm.sh to `/usr/local/bin/` with chown root:root and chmod 755 
Copy fantmppwm.service to `/etc/systemd/system/` with chown root:root and chmod 644

Refresh Service configs: `sudo systemctl daemon-reload`
Enable Fan Control Service to start at boot: `sudo systemctl enable fantmppwm.service`
Start Fan Control now: `sudo systemctl start fantmppwm.service`



# FanControlStromPI
Bash Skript and Debian Service for PWM Based Fan Control using pigpiod and pigs

# Requirements
- Raspberry PI with StromPi Set an Fan connected to GPIO 2.
- Raspberry Pi OS
- No other service using GPIO 2
- package pigpio installed

# Installation
- Copy fantmppwm.sh to `/usr/local/bin/` with chown root:root and chmod 755 
- Copy fantmppwm.service to `/etc/systemd/system/` with chown root:root and chmod 644

- Refresh Service configs: `sudo systemctl daemon-reload`
- Enable Fan Control Service to start at boot: `sudo systemctl enable fantmppwm.service`
- Start Fan Control now: `sudo systemctl start fantmppwm.service`

# Change Settings
Remember to restart with `sudo systemctl restart fantmppwm.service`
```
/usr/local/bin/fantmppwm.sh
# Seconds to wait until next update
REFRESH_SEC=5

# GPIO PIN
FAN_PIN=2
# PWM Frequency
PWM_FRQ=1000

# Duty is human friendly defined as percent 
# if CPU Temperature is lower than TMP_STG1, then take LOW_DUTY value
LOW_DUTY=10
# if CPU Temperature is higher than TMP_STG1, then take STG1_DUTY value
STG1_DUTY=30
# if CPU Temperature is higher than TMP_STG2, then take STG2_DUTY value
STG2_DUTY=50
# if CPU Temperature is higher than TMP_STG3, then take STG3_DUTY value
STG3_DUTY=70
# if CPU Temperature is higher than TMP_STG4, then take STG4_DUTY value
STG4_DUTY=90

TMP_STG1=40
TMP_STG2=50
TMP_STG3=60
TMP_STG4=70
```



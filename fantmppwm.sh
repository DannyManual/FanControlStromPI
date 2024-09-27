#!/bin/bash
REFRESH_SEC=5

FAN_PIN=2
PWM_FRQ=1000

LOW_DUTY=10
STG1_DUTY=30
STG2_DUTY=50
STG3_DUTY=70
STG4_DUTY=90

TMP_STG1=40
TMP_STG2=50
TMP_STG3=60
TMP_STG4=70

request_to_exit=0

setup() {
  # Start pigpiod if not yet started
  if [[ $(pgrep -c "pigpiod") -lt 1 ]]; then
    pigpiod
  fi
  
  # if still not started, exit with error
  [[ $(pgrep -c "pigpiod") -ne 1 ]] && exit 1
  
  # setup pwm
  SET_DUTY=$((255 * LOW_DUTY / 100))
  pigs pfs "$FAN_PIN" "$PWM_FRQ" > /dev/null 
  pigs p "$FAN_PIN" "$SET_DUTY" > /dev/null
}

cleanup() {
  request_to_exit=1

  # turn off gpio pin
  pigs p "$FAN_PIN" 0
  
  # shutdown pigpiod
  killall pigpiod
  exit 0
}

run() {
  while true; do
    [[ request_to_exit -eq 1 ]] && break
    temp=$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))

    CUR_DUTY=10
    [[ "$temp" -ge "$TMP_STG1" ]] && CUR_DUTY="$STG1_DUTY"
    [[ "$temp" -ge "$TMP_STG2" ]] && CUR_DUTY="$STG2_DUTY"
    [[ "$temp" -ge "$TMP_STG3" ]] && CUR_DUTY="$STG3_DUTY"
    [[ "$temp" -ge "$TMP_STG4" ]] && CUR_DUTY="$STG4_DUTY"

    SET_DUTY=$((255 * CUR_DUTY / 100))
    pigs p "$FAN_PIN" "$SET_DUTY"
    
    sleep "$REFRESH_SEC"
  done
}

trap cleanup SIGINT SIGTERM
setup
run

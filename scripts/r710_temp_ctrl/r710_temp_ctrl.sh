#!/bin/sh

HOST=$1
USER=$2
PASSWORD=$3
IEK=0000000000000000000000000000000000000000

# Revert to dynamic fan control if temperature is above this (celsius)
MAX_TEMP=27

BASE_CMD="ipmitool -H ${HOST} -U ${USER} -P ${PASSWORD} -y ${IEK} -I lanplus"

get_temp() {
    TEMP=$(${BASE_CMD} sdr type temperature | grep "Ambient Temp" | awk -F \| '{print $5}' | tr -dc '0-9')
}

set_dynamic() {
    ${BASE_CMD} raw 0x30 0x30 0x01 0x01
}

set_manual() {
    RPM=$1
    ${BASE_CMD} raw 0x30 0x30 0x01 0x00 # Sets control to manual
    ${BASE_CMD} raw 0x30 0x30 0x02 0xff 0x09 # Sets speed
}


main() {
    get_temp
    if [[ $TEMP > $MAX_TEMP ]]; then
        echo "Temperature is ${TEMP} - allowing dynamic fan control"
        set_dynamic
    else
        set_manual "0x09"
    fi
}

main

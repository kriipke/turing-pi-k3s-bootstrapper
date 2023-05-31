#!/bin/bash

set -x 

NODE01_SERIAL=1000000066673056
NODE02_SERIAL=10000000768dc997
NODE03_SERIAL=10000000f3a87dcb
NODE04_SERIAL=10000000fb577539

NODE01_IP=10.2.0.70
NODE02_IP=10.2.0.71
NODE03_IP=10.2.0.72
NODE04_IP=10.2.0.73

RASPI_SERIAL=$(grep Serial /proc/cpuinfo | cut -d: -f 2 | tr -d '[:space:]')
CUSTOM_SCRIPT=/boot/Automation_Custom_Script.sh

case $RASPI_SERIAL in
        "$NODE01_SERIAL")
                awk '{gsub(/NODE_HOSTNAME/,"cube01"); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                awk -v IP=$NODE01_IP '{gsub(/NODE_IPADDRESS/,IP); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                ;;
        "$NODE02_SERIAL")
                awk '{gsub(/NODE_HOSTNAME/,"cube02"); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                awk -v IP=$NODE02_IP '{gsub(/NODE_IPADDRESS/,IP); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                ;;
        "$NODE03_SERIAL")
                awk '{gsub(/NODE_HOSTNAME/,"cube03"); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                awk -v IP=$NODE03_IP '{gsub(/NODE_IPADDRESS/,IP); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                ;;
        "$NODE04_SERIAL")
                awk '{gsub(/NODE_HOSTNAME/,"cube04"); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                awk -v IP=$NODE04_IP '{gsub(/NODE_IPADDRESS/,IP); print}' $CUSTOM_SCRIPT > $CUSTOM_SCRIPT
                ;;
        *)
                echo "ERROR: Serial NOT FOUND. Exiting."
                exit 1
                ;;
esac

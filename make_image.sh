#!/bin/bash

curl -LO https://dietpi.com/downloads/images/DietPi_RPi-ARMv8-Bullseye.7z
7za e DietPi_RPi-ARMv8-Bullseye.7z


LOOP_DEVICE=$(losetup -f)
losetup -P $LOOP_DEVICE DietPi_RPi-ARMv8-Bullseye.img

MOUNT_DIR=$(mktemp -d)
sudo mount ${LOOP_DEVICE}p1 $MOUNT_DIR

cp boot/* $MOUNT_DIR/
umount $MOUNT_DIR

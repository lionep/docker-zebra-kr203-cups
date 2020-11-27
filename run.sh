#!/bin/bash

# Start cupsd server
echo "Starting cups..."
cupsd -f -c /etc/cups/cupsd.conf &

# Wait for cups web api to start
sleep 5

echo "Listing connected printers"
DIRECT_PRINTER=`lpinfo -v | grep '^direct' | grep "Zebra%20Technologies" | cut -d\  -f 2`

# Setup printers
if [ "$DIRECT_PRINTER" != "" ]; then
  echo "Installing $DIRECT_PRINTER"
  lpadmin -p Zebra -E -v "$DIRECT_PRINTER" -P /root/KR203.ppd
  sleep 5
  echo "Apply USB policy"
  # https://wiki.debian.org/CUPSDebugging#Problems_Printing_to_a_USB_Connected_Printer
  lpadmin -p Zebra -o usb-unidir-default=true
  lpadmin -p Zebra -o usb-no-reattach-default=true
else
  echo "Zebra Printer not found."
fi

sleep infinity

# Zebra KR203 printer in a docker

## Docker compose

```
version: '2.1'

services:
  cups:
    image: lionep/zebra-kr203-cups:latest
    hostname: cups
    devices:
      - /dev/bus/usb:/dev/bus/usb
    ports:
      - 127.0.0.1:8631:631
```


Override PPD file with :

```
    volumes:
      - ./file.ppd:/root/DNP.ppd

```

Print with lpr

```
lpr -H 127.0.0.1:631 -P Zebra /file_to_print.png
```

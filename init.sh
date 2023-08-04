#!/bin/sh

echo "Listening on port 12345/tcp, 12346/tcp, 12347/udp, 12348/udp"

nc -lk -p 12345 -e /bin/cat &
nc -lk -p 12346 -e /bin/cat &
nc -lk -p 12347 -u -e /bin/cat &
nc -lk -p 12348 -u -e /bin/cat

#!/bin/sh

onStart() {
  echo "Listening on port 12345/tcp, 12346/tcp, 12347/udp, 12348/udp"
}

onExit() {
  echo "Stopping server..."
  exit 0
}

trap onExit TERM INT

onStart

nc -lk -p 12345 -e /bin/cat &
nc -lk -p 12346 -e /bin/cat &
nc -lk -p 12347 -u -e /bin/cat &
nc -lk -p 12348 -u -e /bin/cat &

wait $!
# If bash is waiting for a command to complete and receives a signal for which a trap has been set, the trap will not be executed until the command completes.
# When bash is waiting for an asynchronous command via the wait builtin,
# the reception of a signal for which a trap has been set will cause the 'wait' builtin to return immediately with an exit status greater than 128,
# immediately after which the trap is executed.

echo "Server has stopped with exit code $?." >&2
onExit

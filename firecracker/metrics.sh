#!/usr/bin/env bash
logs=metrics.fifo

while true
do
    if read line <$logs; then
        echo $line
    fi
done

echo "Reader exiting"

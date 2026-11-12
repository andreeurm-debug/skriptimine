#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo "Käivita skript root või sudo õigustes!"
    exit 1
fi

lahtekaust="/home"
sihtkaust="/home_bcp"
kuupaev=$(date +%d.%m.%Y)

mkdir -p "$sihtkaust"

for kasutaja in $(ls "$lahtekaust"); do
    if [ -d "$lahtekaust/$kasutaja" ]; then
        failinimi="${kasutaja}.${kuupaev}.tar.gz"
        echo "Varundan kasutaja $kasutaja kodukataloogi -> $sihtkaust/$failinimi"
        tar -czf "$sihtkaust/$failinimi" -C "$lahtekaust" "$kasutaja"
    fi
done

echo "Varundamine lõpetatud. Loodud failid kaustas $sihtkaust:"
ls -lh "$sihtkaust"

#!/bin/bash
# Loendab 1 kuni 10 ja katkeb break abil, kui jõuab 7-ni

for (( i=1; i<=10; i++ )); do
    if [ $i -eq 7 ]; then
        echo "Jõudsin 7-ni, katkestan tsükli."
        break
    fi
    echo "Number: $i"
done

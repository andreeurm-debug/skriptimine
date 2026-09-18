#!/bin/bash
# Väljastab kasutajanimed /etc/passwd failist

for kasutaja in $(cut -d: -f1 /etc/passwd); do
    echo "Kasutaja: $kasutaja"
done

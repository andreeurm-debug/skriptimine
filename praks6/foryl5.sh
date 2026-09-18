#!/bin/bash
# Jagab sõnad eraldaja ';' abil

tekst="koer;kass;hiir"
IFS=';'

for soona in $tekst; do
    echo "Sõna: $soona"
done

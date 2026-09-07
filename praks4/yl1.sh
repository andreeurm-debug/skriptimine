#!/bin/bash
# Skript kontrollib, kas sisestatud arv on paaris või paaritu

echo -n "Sisesta suvaline täisarv: "
read arv

# Arvutame jääk 2-ga jagamisel
jaak=`expr $arv % 2`

if [ $jaak -eq 0 ]; then
    echo "Antud arv on paaris"
else
    echo "Antud arv on paaritu"
fi

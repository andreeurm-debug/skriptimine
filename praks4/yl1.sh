#!/bin/bash
# Skript küsib kasutajalt arvu ja ütleb, kas see on paaris või paaritu

echo -n "Sisesta suvaline täisarv: "
read arv

# Arvutame 2-ga jagamise jäägi
jaak=`expr $arv % 2`

if [ $jaak -eq 0 ]; then
    echo "Antud arv on paaris"
else
    echo "Antud arv on paaritu"
fi

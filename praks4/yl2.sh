#!/bin/bash
# Skript arvutab vajaliku busside arvu vastavalt reisijate ja kohtade arvule

echo -n "Sisesta reisijate arv: "
read reisijad

echo -n "Sisesta kohtade arv bussis: "
read kohad

# Arvutame täisbussid ja maha jäävad reisijad
bussid=`expr $reisijad / $kohad`
jaak=`expr $reisijad % $kohad`

# Kui keegi jäi maha, on vaja ühte lisabussi
if [ $jaak -gt 0 ]; then
    bussid=`expr $bussid + 1`
fi

echo "Kokku on vaja $bussid bussi"

#!/bin/bash
# Skript väljastab raami kujulise tärnide ristküliku

echo -n "Sisesta ridade arv: "
read rida

echo -n "Sisesta tarnide arv reas: "
read tarn

for (( i=1; i<=rida; i++ )); do
    echo -n "$i. "
    for (( j=1; j<=tarn; j++ )); do
        # Kui on esimene või viimane rida, VÕI esimene või viimane tärn
        if [ $i -eq 1 ] || [ $i -eq $rida ] || [ $j -eq 1 ] || [ $j -eq $tarn ]; then
            echo -n "* "
        else
            echo -n "  "
        fi
    done
    echo ""
done

#!/bin/bash
# Skript väljastab kujundi tähemärkidest 'o' ja '*'

echo -n "Sisesta ridade arv: "
read rida

for (( i=1; i<=rida; i++ )); do
    echo -n "$i. "
    for (( j=1; j<=rida; j++ )); do
        # Arvutame, millal peab olema 'o' ja millal '*'
        if [ $j -le $((rida - i)) ]; then
            echo -n "o "
        else
            echo -n "* "
        fi
    done
    echo ""
done

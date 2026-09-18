#!/bin/bash
# Pesastatud tsükkel: katkestab mõlemad break 2 abil kui sisemine jõuab 5-ni

for (( i=1; i<=3; i++ )); do
    echo "Väline tsükkel: $i"
    for (( j=1; j<=10; j++ )); do
        echo "  Sisemine tsükkel: $j"
        if [ $j -eq 5 ]; then
            echo "Sisemine jõudis 5-ni! Katkestan mõlemad tsüklid."
            break 2
        fi
    done
done

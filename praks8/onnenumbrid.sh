#!/bin/bash
# Skript leiab kõik õnnenumbrid vahemikus 1000–9999
# Õnnenumber on arv, mille numbrite korduva liitmise tulemus on 7

for (( algne=1000; algne<=9999; algne++ )); do
    arv=$algne
    
    # Kordame numbrite liitmist seni, kuni arv on suurem kui 9 (st ei ole ühekohaline)
    while [ $arv -gt 9 ]; do
        summa=0
        temp=$arv
        
        # Eraldame numbrid ja liidame need kokku
        while [ $temp -gt 0 ]; do
            jaak=$(( temp % 10 ))
            summa=$(( summa + jaak ))
            temp=$(( temp / 10 ))
        done
        
        arv=$summa
    done
    
    # Kui lõpptulemuseks saadi 7, väljastame algse arvu
    if [ $arv -eq 7 ]; then
        echo "$algne"
    fi
done

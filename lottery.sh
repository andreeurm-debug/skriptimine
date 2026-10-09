#!/bin/bash

> player_numbers.txt
> lottery_numbers.txt

read -p "Sisesta oma nimi: " name
if [ -z "$name" ]; then
    name="Unknown"
fi

valideeri_number() {
    local num="$1"
    
    if [[ -z "$num" || ! "$num" =~ ^[0-9]+$ ]]; then
        echo "Viga: Palun sisesta täisarv!"
        return 1
    fi
    
    if [ "$num" -lt 1 ] || [ "$num" -gt 50 ]; then
        echo "Viga: Number peab olema vahemikus 1–50!"
        return 1
    fi
    
    if grep -qx "$num" player_numbers.txt 2>/dev/null; then
        echo "Viga: Oled selle numbri juba valinud!"
        return 1
    fi
    
    return 0
}

echo -e "\nPalun sisesta 5 erinevat numbrit vahemikust 1–50:"
count=1
while [ $count -le 5 ]; do
    read -p "Sisesta $count. number: " input_num
    
    if valideeri_number "$input_num"; then
        echo "$input_num" >> player_numbers.txt
        count=$((count + 1))
    fi
done

echo -e "\n--- Sinu valitud numbrid ---"
cat player_numbers.txt

echo -e "\nLoosin 5 võidunumbrit..."
gen_count=0
while [ $gen_count -lt 5 ]; do
    rand_num=$(( (RANDOM % 50) + 1 ))
    
    if ! grep -qx "$rand_num" lottery_numbers.txt 2>/dev/null; then
        echo "$rand_num" >> lottery_numbers.txt
        gen_count=$((gen_count + 1))
    fi
done

echo -e "\n--- Loositud võidunumbrid ---"
cat lottery_numbers.txt

echo -e "\n--- Kontrollime tulemusi ---"
matches=0

while read -r p_num; do
    echo ""
    echo "Kontrollin numbrit $p_num..."
    
    if grep -qx "$p_num" lottery_numbers.txt; then
        echo "TABAMUS!"
        matches=$((matches + 1))
    else
        echo "Ei tabanud."
    fi
done < player_numbers.txt

case $matches in
    5) result_msg="JACKPOT!" ;;
    4) result_msg="Väga hea tulemus!" ;;
    3) result_msg="Hea tulemus." ;;
    2) result_msg="Kaks tabamust." ;;
    1) result_msg="Üks tabamus." ;;
    0) result_msg="Seekord tabamusi ei olnud." ;;
esac

echo -e "\nMängija: $name"
echo "Tabamusi: $matches / 5"
echo "Hinnang: $result_msg"

current_date=$(date)

{
    echo "========================================"
    echo "Date: $current_date"
    echo "Player: $name"
    echo "Player numbers:"
    cat player_numbers.txt
    echo "Lottery numbers:"
    cat lottery_numbers.txt
    echo "Matches: $matches"
    echo "Result: $result_msg"
} >> results.txt

echo -e "\nTulemus on edukalt salvestatud faili results.txt!"

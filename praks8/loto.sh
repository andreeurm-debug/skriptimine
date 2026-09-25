#!/bin/bash
# Skript genereerib 5 erinevat juhuslikku arvu vahemikus 1–50

temp_file=$(mktemp)

loendur=0
while [ $loendur -lt 5 ]; do
    nr=$(( RANDOM % 50 + 1 ))
    if ! grep -x -q "$nr" "$temp_file"; then
        echo "$nr" >> "$temp_file"
        loendur=$(( loendur + 1 ))
    fi
done

aeg=$(date "+%Y-%m-%d %H:%M:%S")
numbrid=$(tr '\n' ' ' < "$temp_file")
tulemus="$aeg -> Numbrid: $numbrid"

rm -f "$temp_file"

echo "Vali tulemuse väljastamise viis:"
echo "1) Kuva terminalis"
echo "2) Salvesta faili (loto_tulemused.txt)"
echo -n "Valik (1 või 2): "
read valik

if [ "$valik" = "1" ]; then
    echo "$tulemus"
elif [ "$valik" = "2" ]; then
    echo "$tulemus" >> loto_tulemused.txt
    echo "Tulemus salvestati faili loto_tulemused.txt"
else
    echo "Kuvan tulemuse terminalis:"
    echo "$tulemus"
fi

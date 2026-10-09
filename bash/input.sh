#!/bin/bash

read_player_name() {
    local name
    read -p "Sisesta oma nimi: " name
    if [ -z "$name" ]; then
        name="Unknown"
    fi
    echo "$name"
}

validate_number() {
    local num="$1"

    if [[ -z "$num" || ! "$num" =~ ^[0-9]+$ ]]; then
        echo "Viga: Palun sisesta täisarv!"
        return 1
    fi

    if [ "$num" -lt 1 ] || [ "$num" -gt 50 ]; then
        echo "Viga: Number peab olema vahemikus 1–50!"
        return 1
    fi

    if check_in_player_file "$num"; then
        echo "Viga: Oled selle numbri juba valinud!"
        return 1
    fi

    return 0
}

read_player_numbers() {
    echo -e "\nPalun sisesta 5 erinevat numbrit vahemikust 1–50:"
    local count=1
    local input_num

    while [ $count -le 5 ]; do
        read -p "Sisesta $count. number: " input_num

        if validate_number "$input_num"; then
            save_to_player_file "$input_num"
            count=$((count + 1))
        fi
    done
}

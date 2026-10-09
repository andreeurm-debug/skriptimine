#!/bin/bash

generate_lottery_numbers() {
    local gen_count=0
    local rand_num

    while [ $gen_count -lt 5 ]; do
        rand_num=$(( (RANDOM % 50) + 1 ))

        if ! check_in_lottery_file "$rand_num"; then
            save_to_lottery_file "$rand_num"
            gen_count=$((gen_count + 1))
        fi
    done
}

check_matches() {
    echo -e "\n--- Kontrollime tulemusi ---"
    MATCHES=0
    local p_num

    while read -r p_num; do
        echo ""
        echo "Kontrollin numbrit $p_num..."

        if check_in_lottery_file "$p_num"; then
            echo "TABAMUS!"
            MATCHES=$((MATCHES + 1))
        else
            echo "Ei tabanud."
        fi
    done < "$PLAYER_FILE"
}

get_result_message() {
    case $MATCHES in
        5) RESULT_MSG="JACKPOT!" ;;
        4) RESULT_MSG="Väga hea tulemus!" ;;
        3) RESULT_MSG="Hea tulemus." ;;
        2) RESULT_MSG="Kaks tabamust." ;;
        1) RESULT_MSG="Üks tabamus." ;;
        0) RESULT_MSG="Seekord tabamusi ei olnud." ;;
    esac
}

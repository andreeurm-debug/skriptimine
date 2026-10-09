#!/bin/bash

show_header() {
    echo "========================================"
    echo "             LOTOMÄNG 1-50              "
    echo "========================================"
}

show_player_numbers() {
    echo -e "\n--- Sinu valitud numbrid ---"
    read_player_file
}

show_lottery_numbers() {
    echo -e "\n--- Loositud võidunumbrid ---"
    read_lottery_file
}

show_result() {
    echo -e "\nMängija: $PLAYER_NAME"
    echo "Tabamusi: $MATCHES / 5"
    echo "Hinnang: $RESULT_MSG"
}

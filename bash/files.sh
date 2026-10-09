#!/bin/bash

PLAYER_FILE="player_numbers.txt"
LOTTERY_FILE="lottery_numbers.txt"
RESULTS_FILE="results.txt"

clear_files() {
    > "$PLAYER_FILE"
    > "$LOTTERY_FILE"
}

save_to_player_file() {
    local num="$1"
    echo "$num" >> "$PLAYER_FILE"
}

save_to_lottery_file() {
    local num="$1"
    echo "$num" >> "$LOTTERY_FILE"
}

check_in_player_file() {
    local num="$1"
    grep -qx "$num" "$PLAYER_FILE" 2>/dev/null
}

check_in_lottery_file() {
    local num="$1"
    grep -qx "$num" "$LOTTERY_FILE" 2>/dev/null
}

read_player_file() {
    cat "$PLAYER_FILE"
}

read_lottery_file() {
    cat "$LOTTERY_FILE"
}

append_result() {
    local date_str="$1"
    local name="$2"
    local matches="$3"
    local msg="$4"

    {
        echo "========================================"
        echo "Date: $date_str"
        echo "Player: $name"
        echo "Player numbers:"
        cat "$PLAYER_FILE"
        echo "Lottery numbers:"
        cat "$LOTTERY_FILE"
        echo "Matches: $matches"
        echo "Result: $msg"
    } >> "$RESULTS_FILE"
}

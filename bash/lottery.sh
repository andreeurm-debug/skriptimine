#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/files.sh"
source "$DIR/input.sh"
source "$DIR/lottery_functions.sh"
source "$DIR/result.sh"

show_header
clear_files

PLAYER_NAME=$(read_player_name)
read_player_numbers
show_player_numbers

generate_lottery_numbers
show_lottery_numbers

check_matches
get_result_message
show_result

save_result_to_history() {
    local current_date
    current_date=$(date)
    append_result "$current_date" "$PLAYER_NAME" "$MATCHES" "$RESULT_MSG"
    echo -e "\nTulemus on edukalt salvestatud faili $RESULTS_FILE!"
}

save_result_to_history

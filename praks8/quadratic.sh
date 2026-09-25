#!/bin/bash
# Skript lahendab ruutvõrrandi Ax^2 + Bx + C = 0

if [ $# -ne 3 ]; then
    echo "Kasutamine: $0 A B C"
    exit 1
fi

A=$1
B=$2
C=$3

if [ "$A" -eq 0 ] 2>/dev/null; then
    echo "Viga: A ei tohi olla 0!"
    exit 1
fi

# Arvutame awk abil diskriminandi ja lahendid
awk -v a="$A" -v b="$B" -v c="$C" 'BEGIN {
    d = b * b - 4 * a * c;
    if (d < 0) {
        print "Reaalarvulisi lahendeid ei ole.";
    } else if (d == 0) {
        x = -b / (2 * a);
        printf "Võrrandil on üks lahend: x = %.5f\n", x;
    } else {
        x1 = (-b + sqrt(d)) / (2 * a);
        x2 = (-b - sqrt(d)) / (2 * a);
        print "Võrrandil on kaks lahendit:";
        printf "x1 = %.5f\n", x1;
        printf "x2 = %.5f\n", x2;
    }
}'

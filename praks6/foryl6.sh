#!/bin/bash
# Loo proovifailid a.txt, b.txt, c.txt ja väljastab need

touch a.txt b.txt c.txt

for fail in *.txt; do
    echo "Leidsin faili: $fail"
done

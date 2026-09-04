#!/bin/bash
# Skripti eesmärk: kuupäeva, kellaaja ja kalendri väljastamine kohandatud vormingus

# Väljastab kuupäeva näiteks muujul: "Today is Wednesday, February 06, 2019"
date +"Today is %A, %B %d, %Y"

# Väljastab kellaaja kujul: "Time is 13:21"
date +"Time is %H:%M"

echo ""

# Väljastab kalendri päise kujul: "Calendar of February 2019"
date +"Calendar of %B %Y"

# Väljastab kalendri ilma päiseta (võtab viimased 7 rida)
cal | tail -n 7

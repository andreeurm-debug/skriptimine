#!/bin/bash
# Skripti eesmärk: kasutaja tervitamine vastavalt sisselogitud kasutajatunnusele

echo -n "Tere, "
kasutaja=$(whoami)
echo -n "$kasutaja"
echo "!"

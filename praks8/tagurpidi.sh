#!/bin/bash
# Skript väljastab iseenda lähtekoodi tagurpidi

cat "$0" | tac | rev

#!/bin/bash
# PHP paigaldusskript

# Kontrollime, kas skript on käivitatud root või sudo õigustes
if [ "$(whoami)" != "root" ]; then
    echo "Käivita skript root või sudo õigustes!"
    exit 1
fi

# Kontrollime, mitu korda paketi php korral "ok installed" on leitud
PHP=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c 'ok installed')

# Kui PHP muutuja väärtus võrdub 0-ga
if [ "$PHP" -eq 0 ]; then
    echo "Paigaldame php ja vajalikud lisad"
    apt update && apt install -y php libapache2-mod-php php-mysql
    echo "php on paigaldatud"
# Kui PHP muutuja väärtus võrdub 1-ga
elif [ "$PHP" -eq 1 ]; then
    echo "php on juba paigaldatud"
    which php
fi

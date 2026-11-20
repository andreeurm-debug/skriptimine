#!/bin/bash
# Oracle MySQL 8.4 automaatne paigaldusskript

set -e

if [ "$(whoami)" != "root" ]; then
    echo "Käivita skript root või sudo õigustes!"
    exit 1
fi

# Kontrollime, kas mysql-community-server on juba paigaldatud
MYSQL=$(dpkg-query -W -f='${Status}' mysql-community-server 2>/dev/null | grep -c 'ok installed' || true)

if [ "$MYSQL" -eq 1 ]; then
    echo "MySQL server on juba paigaldatud!"
    mysql --version
    systemctl status mysql --no-pager
    exit 0
fi

# Määrame paigalduse mitteküsimuste režiimi
export DEBIAN_FRONTEND=noninteractive

# Uuendame paketiandmebaasi ja paigaldame vajalikud tööriistad
apt update
apt install -y gnupg ca-certificates debconf-utils wget

# 1. Valmistame vastused mysql-apt-config paketi küsimustele automaatselt
echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.4-lts" | debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-tools select Disabled" | debconf-set-selections
echo "mysql-apt-config mysql-apt-config/select-product select Ok" | debconf-set-selections

# 2. Määrame MySQL root-parooliks "qwerty"
echo "mysql-community-server mysql-community-server/root-pass password qwerty" | debconf-set-selections
echo "mysql-community-server mysql-community-server/re-root-pass password qwerty" | debconf-set-selections

# 3. Valime kasutatava autentimisplugina
echo "mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)" | debconf-set-selections

# 4. Laeme alla ja paigaldame MySQL ametliku APT konfiguratsioonipaketi (0.8.40-1)
wget -O /tmp/mysql-apt-config_0.8.40-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.40-1_all.deb
dpkg -i /tmp/mysql-apt-config_0.8.40-1_all.deb
rm -f /tmp/mysql-apt-config_0.8.40-1_all.deb

# 5. Uuendame paketiinfot ja paigaldame MySQL Serveri
apt update
apt install -y mysql-server

# 6. Lubame MySQL teenusel automaatselt käivituda ja käivitame selle kohe
systemctl enable --now mysql

# 7. Loome .my.cnf faili nii root kui ka tavakasutaja kodukataloogi
cat > /root/.my.cnf <<'CNF'
[client]
host=localhost
user=root
password=qwerty
CNF
chmod 600 /root/.my.cnf

if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    cat > "$USER_HOME/.my.cnf" <<'CNF'
[client]
host=localhost
user=root
password=qwerty
CNF
    chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.my.cnf"
    chmod 600 "$USER_HOME/.my.cnf"
fi

echo "Valmis: Oracle MySQL 8.4 on paigaldatud. Root-parool: qwerty"
mysql --version || true

#!/bin/bash

SRC_DIR="$HOME/praks2/src"
BACKUP_DIR="$HOME/praks2/backup"
LOG_FILE="$HOME/praks2/logs/backup.log"
IGNORE_FILE="$SRC_DIR/.backupignore"

mkdir -p "$BACKUP_DIR" "$(dirname "$LOG_FILE")"

logi() {
    echo "[$(date '+%F %T')] $1" | tee -a "$LOG_FILE"
}

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

logi "BACKUP START: Lähtekaust $SRC_DIR"

if [ ! -d "$SRC_DIR" ]; then
    logi "VIGA: Lähtekausta $SRC_DIR ei leitud!"
    exit 1
fi

SRC_SIZE=$(du -sb "$SRC_DIR" | awk '{print $1}')
FREE_SPACE=$(df -B1 "$BACKUP_DIR" | awk 'NR==2{print $4}')
REQUIRED_SPACE=$((SRC_SIZE * 2))

if [ "$FREE_SPACE" -lt "$REQUIRED_SPACE" ]; then
    logi "VIGA: Pole piisavalt vaba ruumi! Vaja: ${REQUIRED_SPACE}B, Vaba: ${FREE_SPACE}B"
    exit 1
fi

KUUPAEV=$(date +%Y-%m-%d_%H-%M-%S)
EXCLUDE_OPT=""
if [ -f "$IGNORE_FILE" ]; then
    EXCLUDE_OPT="--exclude-from=$IGNORE_FILE"
    logi "INFO: Kasutan välistusfaili $IGNORE_FILE"
fi

if command -v zstd >/dev/null 2>&1; then
    ARCHIVE="$BACKUP_DIR/src_${KUUPAEV}.tar.zst"
    tar -I 'zstd -19 -T0' $EXCLUDE_OPT -cf "$ARCHIVE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"
else
    ARCHIVE="$BACKUP_DIR/src_${KUUPAEV}.tar.gz"
    tar $EXCLUDE_OPT -czf "$ARCHIVE" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"
fi

if [ $? -ne 0 ]; then
    logi "VIGA: Arhiveerimine ebaõnnestus!"
    exit 1
fi

if [[ "$ARCHIVE" == *.zst ]]; then
    tar -I 'zstd -d' -tf "$ARCHIVE" > "$TMP_DIR/sisu.txt" 2>/dev/null
else
    tar -tzf "$ARCHIVE" > "$TMP_DIR/sisu.txt" 2>/dev/null
fi

if [ $? -ne 0 ] || [ ! -s "$TMP_DIR/sisu.txt" ]; then
    logi "VIGA: Arhiiv on vigane või tühi!"
    rm -f "$ARCHIVE"
    exit 1
fi

sha256sum "$ARCHIVE" > "$ARCHIVE.sha256"
if sha256sum -c "$ARCHIVE.sha256" >/dev/null 2>&1; then
    SUURUS=$(du -h "$ARCHIVE" | awk '{print $1}')
    logi "OK: Loodud ja kontrollitud arhiiv $ARCHIVE (Suurus: $SUURUS)"
else
    logi "VIGA: SHA-256 kontrollsumma ei klapi!"
    exit 1
fi

cd "$BACKUP_DIR" && ls -1t src_20*.tar.* 2>/dev/null | grep -v '\.sha256$' | tail -n +4 | while read -r vana; do
    rm -f "$vana" "$vana.sha256"
    logi "INFO: Kustutatud vana varukoopia $vana"
done

logi "BACKUP END: Protsess edukalt lõpetatud"

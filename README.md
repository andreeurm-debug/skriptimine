# Skriptimine ja GitHowTo õppeprojekt

Lühike ülevaade skriptimise kursuse käigus õpitud Git versioonihalduse praktilistest harjutustest ja põhitõdedest.

## Projekti kirjeldus

Selle projekti eesmärk oli läbida [GitHowTo](https://githowto.com/) interaktiivne juhend ning omandada praktilised oskused versioonihalduse kasutamiseks käsureal. Projekti käigus õppisin repositooriumi loomist, muudatuste jälgimist, harude haldamist ning koodi modulaarset struktureerimist.

---

## Õpitud teemad ja Git põhitöövoog

Git'i põhitöövoog koosneb muudatuste tegemisest töökaustas (*working directory*), nende etappeerimisest ehk lavastamisest (`git add`) ning salvestamisest ehk commit'imisest (`git commit`).

### Kasutatud Git käsud

- `git status` — kontrollib failide hetkeseisu ja vaatab, millised muudatused on etappeeritud.
- `git add <fail>` — lisab muudetud failid järgmise commiti koosseisu.
- `git commit -m "sõnum"` — salvestab etappeeritud muudatused repositooriumi ajalukku.
- `git log` — kuvab eelmiste commit'ide ajalugu.
- `git branch` — näitab olemasolevaid harusid ja aitab luua uusi.
- `git switch <haru>` — võimaldab liikuda eri harude vahel.
- `git merge <haru>` — ühendab valitud haru muudatused aktiivse haruga.

### Koodinäited ja töövoog

Muudatuste lisamiseks ja commit'imiseks kasutatav tüüpiline käsutada:

```bash
# Vaata failide olekut
git status

# Lisa failid etappeerimisalasse
git add .

# Tõsta muudatused ajalukku
git commit -m "Täienda README faili"

# Liigu uuele harule ja ühenda see
git switch -c uus-funktsionaalsus
git switch master
git merge uus-funktsionaalsus

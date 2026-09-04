#!/bin/bash
# Küpsisetordi pakkide arvutamine expr abil

echo -n "Sisesta aluskandiku pikkus (cm): "
read alus_pikkus

echo -n "Sisesta aluskandiku laius (cm): "
read alus_laius

echo -n "Sisesta küpsise pikkus (cm): "
read kups_pikkus

echo -n "Sisesta küpsise laius (cm): "
read kups_laius

echo -n "Sisesta kihtide arv: "
read kihid

echo -n "Sisesta küpsiste arv ühes pakis: "
read pakis_arv

# Arvutame mitu küpsist läheb ühte kihti ja kokku kogu tordile
ridu=`expr $alus_pikkus / $kups_pikkus`
veerunde=`expr $alus_laius / $kups_laius`
uh_kiht=`expr $ridu \* $veerunde`
kokku_kupsiseid=`expr $uh_kiht \* $kihid`

# Arvutame pakkide arvu (kui tekib jääk, lisame 1 paki juurde)
jagatis=`expr $kokku_kupsiseid / $pakis_arv`
jaak=`expr $kokku_kupsiseid % $pakis_arv`

if [ $jaak -gt 0 ]; then
    pakkide_arv=`expr $jagatis + 1`
else
    pakkide_arv=$jagatis
fi

echo "Kokku on vaja osta $pakkide_arv pakki küpsiseid."

#!/usr/bin/env bash
# Script de  1 ) creation de magasin de clé de type jks avec  2 ) generation de la requête pour depot sur PNCN
# 3 ) import des certificats de la chaine PNCN

read -p "Voulez-vous generer le fichier keystore de type JKS <O/N> " prompt

if [[ $prompt == "o" || $prompt == "O" || $prompt == "oui" || $prompt == "Oui" ]]
then
read -p "Entrez le nom complet du keystore : " keystorename
read -p "Entrez le mot de passe du keystore (storepass/keypass) : " mdp
file=$(echo $keystorename."jks")
req=$(echo $keystorename."csr")
dname=$(echo "CN="$keystorename", OU=Academie de la Martinique, OU=0002 110043015, O=Education Nationale, L=Martinique, C=FR")
echo "Création du keystore"
echo "keytool -genkey -keyalg "RSA" -keysize 2048 -validity 1095 -alias $keystorename -keystore $file -dname $dname -storepass $mdp -keypass $mdp"
keytool -genkey -keyalg "RSA" -keysize 2048 -validity 1095 -alias $keystorename -keystore $file -dname "$dname" -storepass $mdp -keypass $mdp
echo "Generation de la demande pour depot à la PNCN"
keytool -certreq -alias $keystorename -keystore $file -file $req -storepass $mdp -keypass $mdp
echo "copie de sauvegarde keystore avant importation chaine"
cp $file $file."key-only"
echo "import des certificats racine PNCN"
if [[ -f ac-men.cer  || -f ac-menesr.cer || -f ac-men-infrastructures.cer ]]
then
keytool -noprompt -import -alias AC_Racine_ENESR -keystore $file -file ac_racine_menesr.cer -storepass $mdp -trustcacerts
keytool -noprompt -import -alias AC_Education_Nationale -keystore $file -file ac-men.cer -storepass $mdp -trustcacerts
keytool -noprompt -import -alias AC_EN_Infrastructures -keystore $file -file ac-men-infrastructures.cer -storepass $mdp -trustcacerts
else
echo "fichiers de chaine de certification non présents"
fi   
fi


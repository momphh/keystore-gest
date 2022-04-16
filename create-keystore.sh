#!/usr/bin/env bash
# Script de  1 ) creation de magasin de clé de type jks avec  2 ) generation de la requête pour depot sur PNCN
# 3 ) import des certificats de la chaine PNCN

read -p "Voulez-vous generer le fichier keystore de type JKS <O/N> " prompt

if [[ $prompt == "o" || $prompt == "O" || $prompt == "oui" || $prompt == "Oui" ]]
then
read -p "Entrez le nom complet du keysore : " keystorename
read -p "Entrez le mot de passe du keystore (storepass/keypass) : " mdp
file=$(echo $keystorename."jks")
req=$(echo $keystorename."csr")
dname=$(echo "\"CN="$keystorename", OU=Academie de la Martinique, OU=0002 110043015, O=Education Nationale, L=Martinique, C=FR\"")
echo "keytool -genkey -keyalg \"RSA\" -keysize 2048 -validity 1095 -alias $keystorename -keystore $file -dname $dname -storepass $mdp -keypass $mdp"
echo "Generation de la demande pour depot à la PNCN"
echo "keytool -certreq -alias $keystorename -keystore $file -file $req -storepass $mdp -keypass $mdp"
echo "copie de sauvegarde keystore à blanc"
echo "import des certificats racine PNCN"
echo "test"
fi


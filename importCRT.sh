#!/usr/bin/env bash
# Ce script se charge d'importer le certificat fourni par la PNCN dans le keystore 
# paramètre du script le nom du fichier .pem à intégrer

read -p "Entrer le nom du keystore : " keystore
read -p "Entrez le mot de passe du keystore pour intégrer le certificat : " mdp
alias=${keystore%????}
if [[ -f $keystore ]] 
then
echo "keytool -import -alias $alias -keystore $keystore -file $1 -storepass $mdp"
else
echo "keystore non présent"
fi
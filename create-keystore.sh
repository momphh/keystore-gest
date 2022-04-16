#!/usr/bin/env bash
# Script de  1 ) creation de magasin de clé de type jks avec  2 ) generation de la requête pour depot sur PNCN
# 3 ) import des certificats de la chaine PNCN

read -p "Voulez-vous generer le fichier keystore de type JKS <O/N> " prompt

if [[ $prompt == "o" || $prompt == "O" || $prompt == "oui" || $prompt == "Oui" ]]
then
read -p "Entrez son nom complet : " keystorename
read -p "Entrez son alias : " alias
read -p "Entrez le DNAME du keystore ( CN=.... ) : " dname
read -p "Entrez le mot de passe du keystore (storepass/keypass) : " mdp
echo $keystorename."jks"
echo "copie de sauvegarde keystore à blanc"
echo "import des certificats racine PNCN"
echo "test"
fi


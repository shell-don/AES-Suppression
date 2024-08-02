# AES Suppression
Permet de supprimer l'accès d'un fichier de manière sécurisé en le chiffrant un nombre donné de fois en AES-256 et en supprimant la clé.   
 
## Install
Dans le dossier télécharger lancez le Makefile : 
```zsh
make all clean
```
## Usage
Au lancement de l'éxécutable :
```zsh
Quel est le chemin du fichier -glissez le- ?
~/test.txt
```
Puis :
```zsh
Combien de fois voulez-vous le chiffrer avant de le supprimer ?
3
```
Enfin :
```zsh
Chiffrement 1 effectué
Chiffrement 2 effectué
Chiffrement 3 effectué
Le fichier a été effacé avec succès !
```
Remarque : Dès que le processus parents (le terminal lancé en même temps que l'éxécutable) est tué (fermé), les variables du terminal (clés) se rénitialisent.


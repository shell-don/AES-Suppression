/* Implémentation C de bc.sh */
/* obj : le modifier pour l'éfacement */
/* obj : intégrer un générateur de mdp pour éviter d'installer AEScrypt */

#include <stdio.h>
#include <stdlib.h>

int main (void) {
  system( "PATH=/usr/bin:/bin:/usr/sbin:/sbin:/dev:/Users/mathis/Documents/Informatique/Projet/C/aescrypt_mac_v314_1_source/src ; echo Quel est le chemin du fichier -glissez le- ? ; read CHEMIN_FICHIER ; CHEMIN_ORIGINE=$CHEMIN_FICHIER ; echo Combien de fois voulez-vous le chiffrer avant de le supprimer ? ; read n ; i=1 ; until [ $i -gt $n ] ; do x=$(pwgen 999) ; aescrypt -e -p $x $CHEMIN_FICHIER ; if [[ $i -le $n ]] ; then rm $CHEMIN_FICHIER ; fi ; mv ${CHEMIN_FICHIER}.aes $CHEMIN_ORIGINE ; CHEMIN_FICHIER=$CHEMIN_ORIGINE ; echo Chiffrement $i effectué ; ((i++)) ; done ; rm $CHEMIN_ORIGINE ; echo Le fichier a été effacé avec succès !" ) ;
}

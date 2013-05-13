a_fusionner
===========

DESCRIPTION
-----------

En utilisant le webservice merged de l'Abes, renvoie la liste les notices dédoublonnées dans le SUdoc mais non fusionnées dans le SIGB local.
 

UTILISATION
-----------

Nécessite les packages :  LWP::Simple

Accepte une liste de PPN en paramètre, par l'intermédiaire d'un fichier : "liste_de_ppn"

my $fichier_de_base = "liste_de_ppn"


Sortie : 
* dans le fichier "ppn_a_fusioner"
Forme : "PPN notice locale" à fusionner dans "PPN notice dédoublonnée (fusionnée)"
021946582 à fusionner dans 021946585
000062103 à fusionner dans 091932424
000153508 à fusionner dans 159392721

* dans le fichier "ppn_a_fusioner"
Forme : "PPN notice locale" , "PPN notice dédoublonnée (fusionnée)"
021946582 , 021946585
000062103 , 091932424
000153508 , 159392721



LICENCE
-------

GNU/GPL



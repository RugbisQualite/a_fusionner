a_fusionner
===========

DESCRIPTION
-----------

En utilisant le webservice merged de l'Abes, renvoie la liste les notices d�doublonn�es dans le SUdoc mais non fusionn�es dans le SIGB local.
 

UTILISATION
-----------

N�cessite les packages :  LWP::Simple

Accepte une liste de PPN en param�tre, par l'interm�diaire d'un fichier : "liste_de_ppn"

my $fichier_de_base = "liste_de_ppn"


Sortie : 
* dans le fichier "ppn_a_fusioner"
Forme : "PPN notice locale" � fusionner dans "PPN notice d�doublonn�e (fusionn�e)"
021946582 � fusionner dans 021946585
000062103 � fusionner dans 091932424
000153508 � fusionner dans 159392721

* dans le fichier "ppn_a_fusioner"
Forme : "PPN notice locale" , "PPN notice d�doublonn�e (fusionn�e)"
021946582 , 021946585
000062103 , 091932424
000153508 , 159392721



LICENCE
-------

GNU/GPL



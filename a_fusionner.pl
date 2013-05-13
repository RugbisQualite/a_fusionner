#!/usr/bin/perl

use strict;
use warnings;
use LWP::Simple;	# get(url)


#  ~~~~~~~ VERSIONS~~~~~~~~
#  10.12.2012 : Création.
#  12.12.2012 : Récup. du bon PPN depuis le WS ($ppn_merged)
#  12.12.2012 : Fichier de sortie avec PPN local / bon PPN
#  ~~~~~~~ VERSIONS~~~~~~~~

# romain.vanel@gmail.com
# rugbis@ujf-grenoble.fr

=head1 NAME
a_fusionner.pl
=cut

=head1 DESCRIPTION
En utilisant le webservice merged de l'Abes, renvoie la liste les notices dédoublonnées dans le SUdoc mais non fusionnées dans le SIGB local.
=cut

=head1 UTILISATION

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

=cut

=head1 LICENCE

GNU/GPL

=cut


# Paramêtres généraux
my $url_abes_merges_basique = "http://www.sudoc.fr/services/merged/"; 


#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
sub url_generator {
  my ($ppn_a_chercher, $url_basique) = @_;
  chomp($url_basique);
  my $url_construite = "$url_basique$ppn_a_chercher\n" ;
  return $url_construite;
}

#------------------------------------------------------------------------------
sub extracteur_ppn_merged {
  my ($page_brut) = @_ ;
  $page_brut =~ s/.*<result><ppn>(\d{9}).*/$1/;
  #$page_brut =~ m/\d+/;
  $page_brut =~ s/\n//g;
  $page_brut =~ s/.*>(\d{9}).*/$1/;
  return $page_brut;
  #print "$page_brut\n";
}


#------------------------------------------------------------------------------
sub downloader_de_page {
  my ($url,$ppn2) = @_ ;

  if (my $page = get($url)) {

	return $page;
		
	 }
     else {print "PPN : $ppn2 n'est pas une fusion\n";
           return 0;
          };
} 

#------------------------------------------------------------------------------
sub sorti_fichier {
my ($ppn_merged,$ppn2) = @_ ;
print "$ppn2 à fusionner dans $ppn_merged\n";
open(A_CORRIGER, ">>ppn_a_fusioner");
open(A_CORRIGER_VIRG, ">>ppn_a_fusioner_virg");
print A_CORRIGER "$ppn2 à fusionner dans $ppn_merged\n";
print A_CORRIGER_VIRG "$ppn2 , $ppn_merged\n";
close A_CORRIGER;
close A_CORRIGER_VIRG;
}


#==============================================================================
my $fichier_de_base = "ppn"  ;

open(FICHIER_DE_BASE, $fichier_de_base) ||
  die "ficher $fichier_de_base introuvable : $!";
  
my @fichier_de_base = <FICHIER_DE_BASE>;
close FICHIER_DE_BASE ;



foreach my $ligne_fichier_de_base (@fichier_de_base) {

  my $ppn_a_chercher = $ligne_fichier_de_base;
  my $ppn_2 = $ppn_a_chercher;
    chomp($ppn_a_chercher);
    chomp($ppn_2); 
  my $url = url_generator($ppn_a_chercher,$url_abes_merges_basique);
  my $page_merged = downloader_de_page($url,$ppn_2) ;
  unless ($page_merged)  {
    next
    } ;
  my $ppn_merged = extracteur_ppn_merged($page_merged);
  sorti_fichier($ppn_merged,$ppn_2);
}



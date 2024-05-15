#import "config.typ": *
#import "ulb/utils.typ": *

#show: template

= Introduction
Cette section donne une introduction générale du
problème scientifique abordé et décrit la structure de
l’article. Des questions souvent abordées ici sont :

- Quelles sont les applications du problème abordées ?
- Pourquoi la r´esolution du problème est importante ?

= Etat de l'art
Cette section permet de décrire l'état de l'art concernant la question abordée (c-à-d les meilleures solutions disponibles à présent) et de positionner votre travail par rapport à cet état de l'art.
Les différents articles que vous avez lus et utilisés doivent être correctement référencés (Exemple: @small,@big).
Les informations bibliographiques doivent être encodées dans le fichier `References.bib` avec la syntaxe indiquée par les exemples.
Articles publiés sur une revue scientifique / dans les conference proceedings, ainsi que des livres, sont des exemples de bonnes références.
Par contre, la citation de sources web doit être limitée le plus possible (permis dans le cas de la documentation d'outils informatiques).

= Méthodologie <sec:met>

Cette section doit décrire, en manière détaillée:

- Les hypothèses de base de votre approche
- Les fondements mathématiques
- La méthode proposée
- Les jeux de données utilisés (si nécessaire)
- Les instructions nécessaires pour pouvoir reproduire les expériences (par exemple pseudo-code), 

#indent()Ici vous pouvez trouver deux exemples de notation mathématique:

$ f(x) = (x+a) (x+b) $

Maxwell's equations: 

$ 
  B' &= - nabla times E \ 
  E' &= nabla times B - 4 pi j
$

\ 
\

= Résultats

Cette section doit contenir les résultats que vous avez obtenu avec la méthodologie décrite dans la section @sec:met.
Les résultats devront être présentés de préférence sous forme de tableau (cf.
@tab:simParameters) et/ou du diagramme (cf. @fig:tf_plot),
et correctement référencés. Les conditions d'expérimentation (c-à-d matériel et
logiciels utilisés) devront être ainsi indiquées. En plus des résultats mêmes,
cette section devra contenir votre propre analyse et discussion de résultats
(par exemple comparaison par rapport à une méthode de référence)

#align(center)[
  #figure(
    table(
      columns: 2,
      [Information message length], [$k = 16000$ bit],
      [Radio segment size], [$b = 160$ bit],
      [Rate of component codes], [$R_(c c) = 1/3$],
      [Polynomial of component encoders], [$[1, 33\/37, 25\/37]_8$],
    ),
    caption: [
      Simulation Parameters
    ],
  )<tab:simParameters>
]

#align(center)[
  #figure(
    // image: "tf_plot.png",
    [],
    caption: [
      Simulation results on the AWGN channel. Average throughput $k\/n$ vs $E_s\/N_0$.
    ],
  )<fig:tf_plot>
]




= Conclusion 
Cette section contient un rappel des contributions / de résultats importants de
votre article et éventuellement une indication sur les perspectives de
recherche future dans le même domaine.

#bibliography("bibliography.bib")


#counter(heading).update(0)
#set heading(numbering: "1.", supplement: "Annexe")
#show heading: it => {
  show: smallcaps
  set align(center)
  v(20pt, weak: true)
  if it.level == 1{
    set text(font: "STIX Two Text", lang: "fr", size: 10pt, weight: "thin")
    [Annexe \ #it.body]
    v(13.75pt, weak: true)
  }
  else{
    [null]
  }
}

= Annexes
= Salut
salut


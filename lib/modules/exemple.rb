# encoding: UTF-8
=begin
  Pour ouvrir un exemple de Todo-list

  Commande 'todo exemple'
  Ou 'run.rb exemple' en se trouvant dans le dossier Sweet-Todo

=end


clear
notice "Je vais ouvrir un fichier exemple dans Typora…"
notice "Reviens ensuite ici pour avoir des explications"
sleep 3
`open -a Typora "#{App.path_exemple}"`
puts "\n\n\n"
puts <<-EOT

LES PARTIES
-----------

Un fichier Sweet-Todo est composé de trois parties :

    ## Aujourd'hui
    -----------
      Contient les tâches du jour

    ## À venir
    -------
      Contient les tâches des jours suivant

    ## Achevé
    ---------
      Contient les tâches achevées des jours précédents.

Les parties se définissent par :

    #{'## Nom-partie'.jaune}

#{"(*) Le '##' ne se voit pas dans Typora, il est interprété comme titre.".gris}

Normalement, elles n'ont pas à être touchées. Si elles le sont,
il ne faut pas oublier de remettre des `{#today}`, `{#future}`
et `{#acheved}` au bout des titres de chaque partie.

LES JOURS
---------

Les jours sont des éléments des parties, ils se définissent avec 3 dièses et
une espace ('### ').
Ils sont toujours obligatoirement composés de 'Jour Jour-mois Mois Année'.
Par exemple :

    #{'### Mardi 12 février 2020'.jaune}

#{"(*) Le '###' ne se voit pas dans Typora, il est interprété comme titre.".gris}

14 jours avec au moins une tâche sont toujours prêts, dans la
partie "À venir", qui correspondent aux 2 semaines suivant le
jour courant. Ces jours sont préparés automatiquement.

LES TÂCHES
----------

Les tâches sont des éléments des jours, ils se définissent par :

    #{'- [ ] Intitulé de la tâche'.jaune}
    #{'    Une précision sur la tâche'.jaune}
    #{'    - [ ] Une sous-tâche'.jaune}

#{"(*) Les '- [ ]' ne se voient pas dans Typora, ce sont des cases à cocher.".gris}

Dans Typora, on peut créer facilement une tâche à l'aide de `⌘⌥X`.

On peut la cocher ou la décocher avec `⌃X`.

EOT

# Sweet-Todo

Gestion originale des listes de tâches

L'idée est de faire une todo liste par un fichier Markdown (avec liste à puce), ouvrable dans Typora par exemple, qui gère tous les matins les tâches.

Le fichier markdown se présente de cette manière :

~~~markdown

  Aujourd'hui
  -----------

  6 février 2020

  [x] Tâche faite aujourd'hui
  [ ] Tâche à faire aujourd'hui
  [ ] Tâche d'hier reportée

  À venir
  -------

  7 février 2020

  [ ] Tâche du lendemain
  [ ] Autre tâche du lendemain

  8 février 2020

  Achevé
  ------

  Liste des tâches des jours précédents

~~~

Chaque matin, ce programme modifie ce fichier de cette manière :

* il récupère les tâches inachevées de la veille
* il place la veille et les tâches achevées dans la partie "Achevé" du fichier
* il récupère les tâches du jour courant (dans la partie "À venir") et les
  place en jour courant ("Aujourd'hui")
* il y ajoute, en tout premier, les tâches inachevées de la veille
* si nécessaire, il ajoute un jour à la partie "À venir" pour avoir une
  visibilité sur 7 jours (ou 15 ?)

Tous les ans, il repart d'un fichier "propre" en mettant celui-ci en archive.

### Ajout de nouvelles tâches

L'utilisateur peut ajouter de nouvelles tâches simplement en les ajoutant directement dans ce fichier. Dans [Typora](http://typora.com), le raccourci clavier est `⌘⌥x`. Pour marquer ou démarquer une tâche achevée, il suffit de jouer `⌃x` (Ctrl + x).

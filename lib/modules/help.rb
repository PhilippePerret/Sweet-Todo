# encoding: UTF-8
=begin
  Pour l'affichage de l'aide
=end
clear
puts <<-EOT

#{'AIDE DE SWEET-TODO'.bleu}
#{'=================='.bleu}

Présentation
------------

L'application Sweet-Todo permet de gérer les listes de tâches de façon
simple, à partir d'un fichier `markdown` qui sert en même temps de
check-list et en même temps de liste de données.

Pour ouvrir un exemple de fichier `Sweet-Todo`, jouer la commande :

    #{'> todo exemple'.jaune}

En jouant cette commande, on peut voir comment est constitué une
list de tâches Sweet-Todo.

Ouverture du fichier
--------------------

Si le fichier n'est pas automatiquement ouvert par le cron-job,
on peut l'ouvrir à l'aide de :

  #{'> todo open'.jaune}

Ou sans commande :

  #{'> /path/to/Sweet-Todo/run.rb open'.jaune}

Actualisation du fichier
------------------------

Si on utilise un cron-job pour gérer Sweet-Todo, le fichier de
la liste des tâches sera automatiquement actualisé en respec-
tant ce protocole :

  * les tâches inachevées du jour seront conservées
  * les tâches achevées du jour seront passées dans
    la partie 'Achevée'
  * les tâches du jour courant (qui se trouve pour le
    moment dans la partie "À venir") sont mise en tâ-
    ches du jour courant.

Le fichier est donc prêt à être lu et modifié.

Emplacement du fichier des tâches
---------------------------------

Par défaut, le fichier des tâches se trouvent sur le bureau
et porte le nom #{'__SWTODO__.md'.jaune} (avec deux traits
plats de chaque côté).

Si on veut un autre emplacement et un autre nom, il faut les
définir dans le fichier #{'config.rb'.jaune} du dossier de
Sweet-Todo, avec la propriété #{'config.todo_file_path'.jaune}.

Commande 'todo'
---------------

Pour utiliser la commande 'todo', ajouter ces lignes dans votre fichier
'.bash_profile' (ou autre profile :)

Si le dossier a été placé dans le dossier Application :

  #{'todo="/Applications/Sweet-Todo/run.rb"'.jaune}

Sinon :

  #{'todo="$HOME/path/to/Sweet-Todo/run.rb"'.jaune}

Bien sûr, il faut remplacer la partir #{'path/to/'.jaune} par la bonne valeur.

Constitution du fichier Todo
----------------------------

Demander l'affichage de l'exemple pour voir un exemple et avoir le détail
de la composition du fichier.

  #{'> todo exemple'.jaune}

Ou :

  #{'> run.rb exemple # Si on se trouve dans le dossier Sweet-Todo'.jaune}

EOT

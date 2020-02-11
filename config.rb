# encoding: UTF-8
Configuration.define do |config|

# Application pour ouvrir et modifier
# le fichier contenant la liste des tâche
config.default_editor = 'Typora'

# Emplacement du fichier de la liste des tâches
# ------------------------
# config.todo_file_path = File.join(Dir.home, 'Desktop','__SWTODO__.md')
config.todo_file_path = File.join(APPFOLDER,'__SWTODO__.md')


end

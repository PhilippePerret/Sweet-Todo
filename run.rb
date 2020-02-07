#!/usr/bin/env ruby
# encoding: UTF-8
=begin
  Fichier principal appelé par le cron-job pour actualiser
  le fichier des tâches
=end
require_relative './lib/required'

# La commande à jouer. Par défaut, c'est l'actualisation du fichier
COMMAND = ARGV[0]

todofile = TodoFile.new

case COMMAND
when 'update'
  # puts "CODE INITIAL:\n\n#{todofile.init_code}\n\n"
  todofile.update
  todofile.open
  # puts "\n\n\nCODE FINAL :\n\n#{todofile.full_code}"
when 'force-update'
  todofile.update(force: true)
  todofile.open
when 'open'
  todofile.open
when 'test'
  puts "Je dois tester l'application"
when 'help'
  require_module('help')
when 'exemple'
  require_module('exemple')
else
  if COMMAND
    puts "Il faut donner en premier argument la commande de l'application (ou 'help' pour obenir de l'aide)."
  else
    puts "Il faut entrer la commande à exécuter (update, test, help, etc.)"
  end
end

# todofile.open

# puts "todofile.today_part = #{todofile.today_part.children.first}"

# todofile.today_part.children.first.undone_tasks.each do |task|
#   puts "TASK: #{task} #{task.str}"
# end

#!/usr/bin/env ruby -Ku
# encoding: UTF-8
=begin
  Fichier principal appelé par le cron-job pour actualiser
  le fichier des tâches
=end
require_relative './lib/required'

# La commande à jouer. Par défaut, c'est l'actualisation du fichier
CLI.parse
COMMAND = CLI.args[0]

puts "\n\n\n---- [#{Time.now}]"
puts "Ruby version: #{RUBY_VERSION}"
puts "App.verbose: #{App.verbose}"
puts "COMMAND = #{COMMAND}"# if App.verbose

todofile = TodoFile.new

begin
  case COMMAND
  when 'update'
    if todofile.update # On n'ouvre le fichier que s'il a été actualisé
      todofile.open
    end
  when 'data'
    todofile.get_data # pour HOME
  when 'force-update'
    CLI.options.merge!(force: true)
    todofile.update
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
      puts "Il faut donner en premier argument la commande de l'application (ou 'help' pour obtenir de l'aide)."
    else
      puts "Il faut entrer la commande à exécuter (update, test, help, etc.)"
    end
  end
rescue Exception => e
  puts "### UNE ERREUR EST SURVENUE : #{e.message}"
  puts e.backtrace#.join(CR)
end

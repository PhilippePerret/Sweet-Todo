# encoding: UTF-8
# frozen_string_literal: true
=begin
  Script pour supprimer les duplications (lignes identiques) dans l'historique.

  Il suffit de jouer COMMAND-i pour le lancer
=end
require 'fileutils'

PATH = "/Users/philippeperret/Programmation/Sweet-Todo/historique.txt"
PATH_OLD = "/Users/philippeperret/Programmation/Sweet-Todo/historique-OLD.txt"

unless File.exists?(PATH_OLD)
  FileUtils.move(PATH,PATH_OLD)
end
File.delete(PATH) if File.exists?(PATH)

TABLE_LINES = {}
reffile = File.open(PATH,'a')

File.foreach(PATH_OLD).each do |line|
  date, tache = line.split('---')
  if TABLE_LINES.key?(tache)
    puts "OUT -> #{tache}"
    next
  else
    TABLE_LINES.merge!(tache => true)
  end
  reffile.puts(line)
end

File.delete(PATH_OLD)

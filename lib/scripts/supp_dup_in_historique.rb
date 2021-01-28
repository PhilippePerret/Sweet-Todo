# encoding: UTF-8
# frozen_string_literal: true
=begin
  Script pour supprimer les duplications (lignes identiques) dans l'historique.

  Il suffit de jouer COMMAND-i pour le lancer
=end
require 'fileutils'

PATH = "/Users/philippeperret/Programmation/Sweet-Todo/_Historique_travail_.txt"
PATH_OLD = "/Users/philippeperret/Programmation/Sweet-Todo/_Historique_travail_-OLD.txt"

unless File.exists?(PATH_OLD)
  FileUtils.move(PATH,PATH_OLD)
end
File.delete(PATH) if File.exists?(PATH)

TABLE_LINES = {}
reffile = File.open(PATH,'a')

nombre_doublons = 0

File.foreach(PATH_OLD).each do |line|
  if TABLE_LINES.key?(line)
    nombre_doublons += 1
    puts "OUT -> #{line}"
    next
  else
    TABLE_LINES.merge!(line => true)
  end
  reffile.puts(line)
end

File.delete(PATH_OLD)

puts "\nNombre de doublons supprimés : #{nombre_doublons}."

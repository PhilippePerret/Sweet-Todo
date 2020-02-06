# encoding: UTF-8

APPFOLDER = File.expand_path(File.dirname(File.dirname(__FILE__)))
puts "APPFOLDER = #{APPFOLDER}"

require_relative 'required/Lines/Line' # classe abstraite

Dir["#{APPFOLDER}/lib/required/**/*.rb"].each{|m|require m}

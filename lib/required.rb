# encoding: UTF-8
require 'date'
require 'fileutils'

APPFOLDER = File.expand_path(File.dirname(File.dirname(__FILE__)))
APP_FOLDER = APPFOLDER

# Configuration
require_relative 'required/system/Configuration.rb'
require_relative '../config.rb'

require_relative 'required/Lines/Line' # classe abstraite

Dir["#{APPFOLDER}/lib/required/**/*.rb"].each{|m|require m}

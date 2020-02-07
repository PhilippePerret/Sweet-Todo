# encoding: UTF-8
def require_module module_name
  App.require_module(module_name)
end
class App
class << self
  def require_module modname
    modpath = File.join(folder_modules, modname)
    if File.exists?("#{modpath}.rb")
      require modpath
    elsif File.exists?(modpath) && File.directory?(modpath)
      Dir["#{modpath}/**/*.rb"].each{|m|require m}
    else
      raise "Impossible de trouver le module : #{modname.inspect}"
    end
  end

  def verbose
    if @verbose === nil
      @verbose = !CLI.options[:quiet]
    end
    @verbose
  end

  # Path au fichier exemple
  def path_exemple
    @path_exemple ||= File.join(folder_assets, '__SWTODO__.md')
  end

  # Dossier des backups
  def folder_backups
    @folder_backups ||= File.join(APPFOLDER,'xBackups')
  end

  # Dossier assets
  def folder_assets
    @folder_assets ||= File.join(APPFOLDER,'lib','assets')
  end
  # Dossier des modules
  def folder_modules
    @folder_modules ||= File.join(APPFOLDER,'lib','modules')
  end
end #/<< self
end #/App

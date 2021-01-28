# encoding: UTF-8
=begin
  Classe TodoFile
  ---------------
  Gestion du fichier _TODO_.md en tant que fichier
=end

class TodoFile

  attr_reader :today_part, :future_part

  def initialize

  end

  # Actualise le fichier pour le mettre à aujourd'hui
  def update
    puts "-> update"
    # On a besoin de parser le fichier courant (même s'il sera
    # remplacé)
    parse

    # Dans le cas où le fichier actuel est déjà un fichier pour
    # aujourd'hui
    if today_part.children.first.date == Date.today
      if CLI.options[:force]
        return false unless force_update
      else
        notice "Le fichier est déjà le fichier du jour." if App.verbose
        puts "<- update"
        return false
      end
    end
    # On actualise le code et on l'enregistre
    File.open(path,'wb') { |f| f.write updated_code }

    puts "<- update"
    return true
  end

  # Écrit en console les données à retourner, par exemple pour HOME
  # Les données sont les données courantes
  def get_data
    started = false
    lines = []
    init_code.each_line do |str|
      next if str.strip == '' # on passe les lignes vides
      if str.match?(/\{#today\}/)
        started = true
      elsif !started
        next
      end
      break if str.match?(/\{#future\}/)
      if str.strip.start_with?('- [')
        lines << str[2..-1].strip
      end
      # lines << str
    end
    puts "[[DATA::#{Marshal.dump(lines)}]]"
  end

  # On doit forcer l'actualisation, donc en repartant
  # du fichier de la veille (qui doit impérativement
  # exister)
  def force_update
    # ATTENTION : toutes les tâches du jour seront perdues
    question = "Attention, si je force l'actualisation, toutes les\ntâches ajoutées aujourd'hui seront perdues.\n\nDois-je procéder quand même ?"
    unless yesNo(question)
      return
    end
    error "Il n'y a plus de “fichier de la veille”."
    error "Je dois renoncer à forcer l'actualisation."
    return false
  end

  def updated_code
    # On s'assure qu'il y ait 15 jours dans l'avenir
    # Note : vraiment 15 car on doit retirer le premier jour
    # On doit commencer par cette méthode qui s'assure qu'aujourd'hui
    # a toujours une date (en la créant si nécessaire)
    future_part.ensure_quinzaine
    # La vieille
    veille = today_part.children.first # Une (ligne de) Date
    # On récupère les tâches inaccomplies
    undone_tasks = veille.undone_tasks
    # On ne conserve dans la veille que les tâches accomplies
    # Note : normalement, elles ont toutes été mises de côté au cours
    # du parsing du fichier des tâches.
    veille.delete_undone_tasks()
    # On retire la veille de la partie aujourd'hui
    today_part.delete_child(veille)
    # On prend le jour suivant (aujourd'hui, en fait)
    today = future_part.children.first
    # On le retire de la partie "à venir"
    future_part.delete_child(today)
    # On l'ajoute à la partie aujourd'hui
    today_part.add_child(today)
    # On lui ajoute les tâches inaccomplies
    today.add_children(undone_tasks)
    # Le code complet
    return full_code
  end


  # Pour ajouter une tâche faite dans le fichier historique.
  # Maintenant, on ne les garde plus dans le fichier courant
  def add_historique(line)
    line = line[6..-1].strip if line.start_with?('- [x] ')
    @hier_str ||= (Time.now - 3600*24).strftime('%d %m %Y')
    @refhisto ||= File.open(File.join(APPFOLDER,'_Historique_travail_.txt'),'a')
    @refhisto.puts("#{@hier_str} --- #{line}")
  end #/ add_historique

  def open
    puts "-> open"
    cmd = "open -a \"#{CONFIG[:default_editor]}\" \"#{path}\""
    puts "Commande jouée : #{cmd}" if App.verbose
    `#{cmd}`
    puts "<- open"
  end

  def full_code
    fcode = []
    children.each {|child| fcode << child.full_code}
    fcode.join("\n")
  end

  def reset
    # puts "-> reset"
    [:children, :init_code, :lines, :today_part, :future_part].each do |prop|
      instance_variable_set("@#{prop}", nil)
    end
  end

  def children
    @children ||= [today_part, future_part]
  end

  def init_code
    @init_code ||= File.read(path).force_encoding('utf-8')
  end

  def parse
    @lines = []
    current_part = nil
    current_date = nil
    current_cbox = nil

    if (init_code.strip.empty?)
      error "Le fichier de référence est vide… Un problème a dû survenir. Je reconstitue un fichier type."
      reset_a_new_file
    end

    init_code.each_line do |str|
      next if str.strip == '' # on passe les lignes vides
      line = nil
      if str.include?(balise_start_today)
        # => La marque de la section aujourd'hui
        line = PartLine.new(str, :today)
        current_part = line
        @today_part = line
      elsif str.include?(balise_start_future)
        line = PartLine.new(str, :future)
        current_part = line
        @future_part = line
      elsif str.include?('### ')
        line = DateLine.new(str)
        current_date = line
        current_part.add_child(line)
      elsif str.strip.start_with?('- [x] ')
        add_historique(str.strip)
        next
      elsif str.match?(/\- \[ \] /)
        line = CbLine.new(str)
        current_cbox = line
        current_date.add_child(line)
      else
        # Une ligne "normale"
        next if current_cbox.nil?
        line = NormalLine.new(str)
        current_cbox.add_child(line)
      end
      # puts "line: #{str}"
      @lines << line
    end
    # puts "@lines = #{@lines.inspect}"
  ensure
    # On ferme le fichier historique qui a été ouvert pour y mettre
    # les tâches accomplies
    @refhisto.close if @refhisto
  end

  # En cas de problème, on peut reconstituer un fichier du jour
  # Pour que ça fonctionne, il faut vider entièrement le fichier
  # __SWTODO__.md
  def reset_a_new_file
    idata   = PartLine.new("date quelconque", :today)
    hier    = Time.now - 3600 * 24
    today   = idata.formate_line_for(Time.now)
    hier    = idata.formate_line_for(hier)
    avant_hier  = idata.formate_line_for(Time.now - (3600 * 24 * 2) )
    @init_code = <<-MARKDOWN
# LISTE TODO

## Aujourd'hui {#today}

#{hier}

- [x] Une tâche achevé hier.
- [ ] Une tâche non achevée de la veille.

## À venir {#future}

#{today}

## Achevé {#acheved}

#{avant_hier}

- [x] Une tâche exécutée

    MARKDOWN
  end

  def balise_start_today
    @balise_start_today ||= '{#today}'
  end
  def balise_start_future
    @balise_start_future ||= '{#future}'
  end

  def path
    @path ||= CONFIG[:todo_file_path]
  end
end #/TodoFile

# encoding: UTF-8
=begin
  Classe TodoFile
  ---------------
  Gestion du fichier _TODO_.md en tant que fichier
=end

class TodoFile

  attr_reader :today_part, :future_part, :acheved_part

  def initialize

  end

  def updated_code
    # La vieille
    veille = today_part.children.first # Une (ligne de) Date
    # On récupère les tâches inaccomplies
    undone_tasks = veille.undone_tasks
    # On ne conserve dans la veille que les tâches accomplies
    veille.delete_undone_tasks()
    # On glisse la veille dans la partie achevée
    acheved_part.add_child(veille)
    # On retire la veille de la partie aujourd'hui
    today_part.delete_child(veille)
    # On prend le jour suivant (aujourd'hui, en fait)

  end

  def parse
    @lines = []
    current_part = nil
    current_date = nil
    current_cbox = nil

    File.read(path).force_encoding('utf-8').each_line do |str|
      next if str.strip == '' # on passe les lignes vides
      line = nil
      if str.include?(balise_start_today)
        # => La marque de la section aujourd'hui
        line = PartLine.new(str, {type: :part, for: :today})
        current_part = line
        @today_part = line
      elsif str.include?(balise_start_future)
        line = PartLine.new(str, {type: :part, for: :future})
        current_part = line
        @future_part = line
      elsif str.include?(balise_start_acheved)
        line = PartLine.new(str, {type: :part, for: :acheved})
        current_part = line
        @acheved_part = line
      elsif str.include?('### ')
        line = DateLine.new(str, {type: :date})
        current_date = line
        current_part.add_child(line)
      elsif str.match?(/\- \[[ x]\] /)
        line = CbLine.new(str, {type: :cb})
        current_cbox = line
        current_date.add_child(line)
      else
        # Une ligne "normale"
        line = NormalLine.new(str, {type: :normal})
        current_cbox.add_child(line)
      end
      # puts "line: #{str}"
      @lines << line
    end
    # puts "@lines = #{@lines.inspect}"
  end

  def balise_start_today
    @balise_start_today ||= '{#today}'
  end
  def balise_start_future
    @balise_start_future ||= '{#future}'
  end
  def balise_start_acheved
    @balise_start_acheved ||= '{#acheved}'
  end

  def path
    @path ||= TODO_FILE_PATH # cf. constants.rb
  end
end #/TodoFile

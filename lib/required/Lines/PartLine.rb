# encoding: UTF-8
=begin
  Classe PartLine
  ---------------
  Pour une ligne de partie
=end
class PartLine < Line

  attr_reader :for # :today, :future ou :acheved

  def initialize str, forpart
    super(str, {type: :part, for: forpart})
  end

  # Méthode qui s'assure que la possède 15 jours
  # (sert seulement pour :future (future_part))
  def ensure_quinzaine
    # On commence toujours par classer les enfants par date
    @children = children.sort_by { |child| child.yyyymmdd }
    upto_day = Date.today + 15
    last_day  = Date.today - 1
    # La nouvelle liste pour cette partie
    new_dates = []
    while last_day < upto_day
      last_day = last_day + 1
      last_day_yyyymmdd = last_day.strftime('%Y%m%d')
      if table_dates.key?(last_day_yyyymmdd)
        dateline = table_dates[last_day_yyyymmdd]
      else
        dateline = DateLine.new(formate_line_for(last_day))
        dateline.add_child(CbLine.new("- [ ] Première tâche du jour"))
      end
      new_dates << dateline
    end
    @children = new_dates
  end

  def formate_line_for adate
    @datelineformat ||= "\#\#\# _JOURH_ %-d _MOIS_ %Y"
    adate.strftime(@datelineformat).sub(/_MOIS_/, MONTHNAMES[adate.month]).sub(/_JOURH_/, DAYNAMES[adate.wday])
  end

  def final_str
    @final_str ||= begin
      s = ""
      s << RC*3 if type != :today
      s << str
      s << RC*2
      s
    end
  end

  # Pour écrire les enfants en console
  def puts_children
    children.each { |child| puts "#{child.id} #{child.str} ::#{child.type}"}
  end

  # Méthode surtout utile pour le part :today qui récupère les
  # tâche accomplies
  def done_tasks
    @done_tasks ||= begin
      a = []
      children.first.children.each do |cbox|
        a << cbox if cbox.done?
      end
      a
    end
  end

  # Pour la partie "future" surtout, on produit une table
  # qui contient en clé la date (au format 'AAAAMMJJ') et en valeur
  # la DateLine correspondte
  def table_dates
    @table_dates ||= begin
      h = {}
      children.each do |child| # des DateLine forcément
        h.merge!( child.yyyymmdd => child)
      end
      h
    end
  end
end

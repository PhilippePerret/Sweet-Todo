# encoding: UTF-8
=begin
  Class DateLine
  ----------------
  Une ligne "date", contenant un jour
=end
require 'date'
MONTHNAMES = [
  nil,
  'janvier',
  'février',
  'mars',
  'avril',
  'juin',
  'juillet',
  'aout',
  'septembre',
  'octobre',
  'novembre',
  'décembre'
]
DAYNAMES = [
  'Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'
]

MOISSTR_TO_MOIS = {
  'janvier' => 1, 'jan' => 1, 'jan.' => 1, '01' => 1,
  'février' => 2, 'fév' => 2, 'fév.' => 2, 'fev' => 2, 'fev.' => 2, '02' => 2,
  'mars' => 3, '03' => 3,
  'avril' => 4, 'avr' => 4, 'avr.' => 4, '04' => 4,
  'mai' => 5, '05' => 5,
  'juin' => 6, '06' => 6,
  'juillet' => 7, 'juil' => 7, 'juil.' => 7, '07' => 7,
  'août' => 8, 'aout' => 8, '08' => 8,
  'septembre' => 9, 'sept' => 9, 'sept.' => 9, '09' => 9,
  'octobre' => 10, 'oct' => 10, 'oct.' => 10, '10' => 10,
  'novembre' => 11, 'nov' => 11, 'nov.' => 11, '11' => 11,
  'décembre' => 12, 'déc' => 12, 'déc.' => 12, 'dec' => 12, 'dec.' => 12, '12' => 12,
}

class DateLine < Line

  # Le jour du mois (0-31)
  attr_reader :jour
  # Le mois de l'année (1-12)
  attr_reader :mois
  # Le mois humain, tel que fourni dans la ligne
  attr_reader :mois_str
  # L'année, telle que donnée dans l'année
  attr_reader :annee
  # L'année en 4 chiffres
  attr_reader :full_annee
  # L'instance Date de la date de la ligne
  attr_reader :date
  # La date [String] telle que fournie dans la ligne, après '### '
  attr_reader :date_str

  def initialize str
    super(str, {type: :date})
    parse
  end

  def final_str
    @final_str ||= begin
      RC + str + (RC * 2)
    end
  end
  # Pour enlever les tâches inaccomplies du jour courant (qui eest la veille,
  # quand le programme le fait)
  def delete_undone_tasks
    new_children = []
    children.each do |cbox|
      new_children << cbox if cbox.done?
    end
    @children = new_children
  end

  # Méthode surtout utile pour le part :today qui doit récupérer les
  # tâche inaccomplies du jour précédent
  def undone_tasks
    @undone_tasks ||= begin
      a = []
      children.each do |cbox|
        a << cbox unless cbox.done?
      end
      a
    end
  end

  # Parse la ligne de date, qui se présente avec ce format :
  #   '### JJ MMMM AAAA'
  def parse
    @date_str = str[4..-1]
    # puts "@date_str = #{@date_str.inspect}"
    @jourh, @jour, @mois_str, @annee = @date_str.split(' ')
    @annee = (@annee || Date.today.year).to_i
    @jour = @jour.to_i
    @mois = MOISSTR_TO_MOIS[@mois_str.downcase]
    begin
      @date = Date.new(@annee, @mois, @jour)
    rescue Exception => e
      raise "La date #{@date_str.inspect} est mauvaise, impossible de la déterminer (#{e.message})"
    end
    @full_annee = @date.year
  end

  def yyyymmdd
    @yyyymmdd ||= date.strftime("%Y%m%d")
  end
end

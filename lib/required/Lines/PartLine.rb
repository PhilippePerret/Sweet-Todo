# encoding: UTF-8
=begin
  Classe PartLine
  ---------------
  Pour une ligne de partie
=end
class PartLine < Line

  attr_reader :for # :today, :future ou :acheved


  # Méthode surtout utile pour le part :today qui doit récupérer les
  # tâche inaccomplies du jour précédent
  def undone_tasks
    @undone_tasks ||= begin
      a = []
      children.first.children.each do |cbox|
        a << cbox unless cbox.done?
      end
      a
    end
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
end

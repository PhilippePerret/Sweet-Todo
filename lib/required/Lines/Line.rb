# encoding: UTF-8
=begin

  Classe abstraite Line
  ---------------------
  Toutes les lignes en héritent

=end
class Line

  class << self
    def new_id
      @last_id ||= 0
      @last_id += 1
    end
  end #/<< self

  attr_reader :id, :str, :type
  attr_accessor :parent
  attr_reader :children


  def initialize str, params
    @str = str.strip
    @children ||= []
    params.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
    @id = self.class.new_id
  end

  # Retourne le code complet pour cette "line"
  # Par exemple la partie avec tous ses enfants
  def full_code
    fcode = []
    fcode << final_str
    children.each { |child| fcode << child.full_code }
    fcode.join('')
  end

  # Sera souvent surclassé
  def final_str
    @final_str ||= "#{str}#{RC}"
  end

  def add_child child
    @children << child
    child.parent = self
  end

  def add_children children_list
    children_list.each { |child| add_child child }
  end

  def delete_child child
    @children = children.reject{|line| line.id == child.id}
  end

end

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
    @str = str
    params.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

  def add_child child
    @children ||= []
    @children << child
    child.parent = self
  end

  def delete_child child
    @children = children.reject{|line| line.id == child.id}
  end

end

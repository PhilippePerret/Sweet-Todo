# encoding: UTF-8
=begin
  Class DateLine
  ----------------
  Une ligne "date", contenant un jour
=end

class DateLine < Line


  # Pour enlever les tâches inaccomplies du jour courant (qui eest la veille,
  # quand le programme le fait)
  def delete_undone_tasks
    new_children = []
    this.children.each do |cbox|
      new_children << cbox if cbox.done?
    end
    @children = new_children
  end

end

# encoding: UTF-8
=begin
  Class NormalLine
  ----------------
  Une ligne "normale", ni une partie, ni une date, ni une checkbox
=end

class NormalLine < Line
  def initialize ostr
    lenfull = ostr.rstrip.length
    len = ostr.strip.length
    heading = " " * (lenfull - len)
    super(ostr, {type: :normal})
    @str = heading + str
  end
end

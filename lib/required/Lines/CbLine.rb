# encoding: UTF-8
class CbLine < Line

  def initialize str
    super(str, {type: :cb})
  end

  def done?
    @is_done ||= str.start_with?('- [x] ')
  end

end

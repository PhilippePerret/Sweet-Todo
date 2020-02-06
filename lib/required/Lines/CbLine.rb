# encoding: UTF-8
class CbLine < Line


  def done?
    @is_done ||= str.include?('- [x] ')
  end
  
end

# encoding: UTF-8
# frozen_string_literal: true
class CbLine < Line

  def initialize str
    super(str, {type: :cb})
  end

  def done?
    @is_done ||= str.start_with?('- [x] ')
  end

  # Ligne finale écrite dans le fichier
  # 23 09 2020
  #   Ajout du leading permettant de tenir compte des imbrications
  def final_str
    @final_str ||= "#{leading}#{str}#{RC}"
  end

end
